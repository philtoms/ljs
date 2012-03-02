myZappa = (port,db,app) -> 

 # wrap zappa with extras, then run app in 'myZappa' context

 #helpers to convert a route to text, and then from camelCase to spaced words
 toText = (r,t) -> if r=='/' then t else r.substr(1)
 toTitle = (r,t) -> toText(r,t).replace(/([A-Z])/g, (m)->' '+m.toLowerCase())
                               .replace(/^../, (m)->m.substr(1).toUpperCase())

 store = require('nstore').extend(require('./lib/nstore.query')()).new db, ->
  
  zappa port, -> # passes this fn to zappa.run
    @store = store
    @nav = (routes) ->
      for r in routes 
       do(r) =>
        r = r.toLowerCase()
        routeHandler = {} #use this syntax to get a variable into a key
        routeHandler[r] = ->
          id = toText r,'index'
          page = (key) -> key.indexOf(id)==0
          store.find page,(err,data) =>
            view = {}
            view[id] =
              id: id
              data: data
              tailscript: '/googlea'
              stylesheet: 'style/basestyle'
              nav: routes
              toTitle: toTitle
            
            @render view

        @get routeHandler
           
    # apply 'zappa' context here
    app.apply(this)
    
zappa = require('zappa')
return module.exports = myZappa