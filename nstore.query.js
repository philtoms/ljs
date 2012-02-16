// This plugin adds simple queries to nStore
module.exports = function QueryPlugin() {
  return {

    // Get all the records as either a single object or a document/key stream
    all: function all(callback) {
      return this.find(undefined, callback);
    },

    // Find records using a query
    find: function find(query, callback) {
      var query = compileQuery(query);
      var filter = query.filter;
      var loadDoc = query.loadDoc;
      var stream;
      var results = {};
      if (!callback) {
        stream = new EventEmitter();
      }
      var keys = Object.keys(this.index);
      var counter = keys.length;
      if (!counter) return callback(null, []);
      if(keys.length === 0) {
        process.nextTick(function() {
          if (stream) stream.emit('end');
          if (callback) callback(null, results);
        });
      } else { 
        keys.forEach(function (key) {
          if (loadDoc) {
            this.get(key, function (err, doc, key) {
              if (err) {
                if (stream) stream.emit('error', err);
                if (callback) callback(err);
                return;
              }
              if (filter(doc, key)) {
                if (stream) stream.emit('document', doc, key);
                if (callback) results[key] = doc;
              };
              counter--;
              if (counter === 0) {
                if (stream) stream.emit('end');
                if (callback) callback(null, results);
              }
            });
          }
          else { // filtered on key, so only load matching docs
            if (filter(key)) {
              this.get(key, function (err, doc, key) {
                if (err) {
                  if (stream) stream.emit('error', err);
                  if (callback) callback(err);
                  return;
                }
                if (stream) stream.emit('document', doc, key);
                if (callback) results[key] = doc;
                counter--;
                if (counter === 0) {
                  if (stream) stream.emit('end');
                  if (callback) callback(null, results);
                }
              });
            }
            else {
              counter--;
              if (counter === 0) {
                if (stream) stream.emit('end');
                if (callback) callback(null, results);
              }
            }
          }
        }, this);
      }
    }
  };
}

function compileQuery(query) {
  if (typeof query === 'function') {
    return {filter:query,loadDoc:query.length>1};
  }
  var exp;
  if (Array.isArray(query)) {
     exp = query.map(compileSection).join(" || ") || "true";
  } else if (typeof query === 'object') {
    exp = compileSection(query);
  } else {
    exp = "true";
  }
  return {filter:new Function("doc", "key", "return " + exp + ";"),loadDoc:exp.indexOf("doc.")>0};
}

function compileSection(obj) {
  var parts = Object.keys(obj).map(function (key) {
    var p = key.indexOf(" ");
    var name = key;
    var operator = "=";
    if (p > 0) {
      name = key.substr(0, p);
      operator = key.substr(p + 1);
    }
    if (operator === '=') operator = '===';
    if (operator === '<>') operator = '!==';
    if (name !== "key") {
      name = "doc." + name;
    }
    return "(" + name + " " + operator + " " + JSON.stringify(obj[key]) + ")";
  });
  return "(" + parts.join(" && ") + ")";
}
