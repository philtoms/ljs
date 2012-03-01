/*jslint node: true, nomen: true, maxlen: 80, indent: 4 */

"use strict";

var cache = {},
    fs = require('fs'),
    path = require('path'),
    cs=require("coffee-script"),
    vm = require('vm');

module.exports = function (file, descriptor, all) {
    var context, // the module-level context the file will run under
        data, // file content
        i, // iterator
        mocks; // where the mock objects are stored

    // descriptor is an optional parameter
    // not including it makes injectr like a sandbox wrapper
    descriptor = descriptor || {};

    // don't load any file more than once
    // module.exports should be blank ready for exporting
    context = {
        module : {
            exports : {}
        }
    };

    // include the exports variable, so user can use this as an alternative to
    // module.exports
    context.exports = context.module.exports;

    // include timer variables
    context.setTimeout = setTimeout;
    context.clearTimeout = clearTimeout;
    context.setInterval = setInterval;
    context.clearInterval = clearInterval;

    // include other globals, which also helps with errors
    context.console = console;
    context.process = process;
    context.global = global;

    // sort out the __filename and __dirname
    context.__filename = path.resolve(file);
    context.__dirname = path.dirname(context.__filename);

    //expose mocks extension (fakes?)
    context.mock = function(fakes){
      for (var f in fakes) mocks[f]=fakes[f];
    }

    context._require = require;
    
    // a wrapper for require... if the user has given a mock, use that
    context.require = function (lib) {
        if (mocks.hasOwnProperty(lib)) {
            return mocks[lib];
        }
        if (lib.indexOf('.') === 0) {
            lib = path.resolve(path.join(path.dirname(file), lib));
        }
        try{
          // coffeescript?
          if (lib.lastIndexOf(".coffee")>0){
            var data = fs.readFileSync(lib, 'utf8');
            data = cs.compile(data);
            var r = vm.runInNewContext(data,context,lib);
            return r;
          }
          context.lib=lib;
          return vm.runInNewContext('_require(lib)',context,'injectr.js');
        }
        catch(err) {}
    };

    if (descriptor.context || descriptor.mocks) {
        for (i in descriptor.context) {
            if (descriptor.context.hasOwnProperty(i)) {
                context[i] = descriptor.context[i];
            }
        }
        mocks = descriptor.mocks || {};
    } else {
        mocks = descriptor || {};
    }
    
    // this means the user can use includr in setup, because it's nice and quick
    if (!cache[file]) {
        // use sync version because `require` is sync, so that's what the user
        // expects
        data = fs.readFileSync(file, 'utf8');
        // coffeescript?
        if (file.lastIndexOf(".coffee")>0)
          data = cs.compile(data);
          
        cache[file] = vm.createScript(data, file);
    }

    // run the included file
    cache[file].runInNewContext(context);

    // if the user wants the whole object, not just the exports, give it to them
    if (all) {
        return context;
    }
    return context.module.exports;
};
