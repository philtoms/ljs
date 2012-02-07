(function() {

  require('./myZappa')(function() {
    this.use('bodyParser', this.app.router, 'static');
    this.nav(['/', '/Services', '/GetAQuote', '/OurCustomers', '/Gallery', '/RealLifeStories', '/AnyQuestions']);
    this.post({
      '/sendform': function() {
        require('./sendmail').send.call(this, this.request);
        return this.redirect('/');
      }
    });
    this.js({
      '/googlea.js': '	  var _gaq = _gaq || [];\n  _gaq.push([\'_setAccount\', \'UA-8814132-5\']);\n  _gaq.push([\'_trackPageview\']);\n\n(function() {\n  var ga = document.createElement(\'script\'); ga.type = \'text/javascript\'; ga.async = true;\n  ga.src = (\'https:\' == document.location.protocol ? \'https://ssl\' : \'http://www\') + \'.google-analytics.com/ga.js\';\n  var s = document.getElementsByTagName(\'script\')[0]; s.parentNode.insertBefore(ga, s);\n})();'
    });
    return this.app.params = {
      email: {
        to: 'pip.squeek@hotmail.co.uk',
        error: {
          message: ''
        }
      },
      mobile: '07583 338259'
    };
  });

}).call(this);
