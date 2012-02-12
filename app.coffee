store = require('nstore').extend(require('nstore/query')()).new 'blog.db', ->
 require('./myZappa') ->
  @store = store
  #@enable 'default layout'
  @use 'bodyParser', @app.router, 'static'
  #console.log @everyone

  @include './viewsync'
  
#    @configure
 #   development:@email={to:'pip.squeek@hotmail.co.uk'}
  #  production:@email={to:'watson.stephen5@gmail.com',pwd:'lucy1973'}

  @nav [
    '/'
    '/Services'
    '/GetAQuote'
    '/OurCustomers'
    '/Gallery'
    '/RealLifeStories'
    '/AnyQuestions'
    ]
 
  @post '/sendform' : ->
    require('./sendmail').send.call(this, @request)
    @redirect '/'
 
  @js '/googlea.js': '''
	  var _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'UA-8814132-5']);
    _gaq.push(['_trackPageview']);
  
  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
  '''

  @app.params = 
    email:
      to:'watson.stephen5@gmail.com'
      pwd:'lucy1973'
      error:
        message:''
    mobile:'07583 338259'
