run = require('zappa')

#helpers to convert a route to text, and then from camelCase to spaced words
toText = (r,t) -> if r=='/' then t else r.substr(1)
toTitle = (t) -> t.replace(/([A-Z])/g, (str)->' '+str.toLowerCase())
                  .replace(/^../, (str)->str.substr(1).toUpperCase())

# wrap app context with extras and export as 'zappa'
module.exports = (app) -> 
  run -> # passes this fn to zappa.run
    @includeRoute = (r,routes) ->
      routeHandler = {} #use this syntax to get a variable into a key
      routeHandler[r.toLowerCase()] = ->
        view = {}
        view[toText r.toLowerCase(),'index'] = 
          tailscript:'/googlea'
          stylesheet: 'style/basestyle'
          nav: ->
            ul=['<ul>']
            for r in routes
              ul.push '<li><span>*</span><a href="'+r.toLowerCase()+'">'+toTitle toText(r,'Home')+'</a></li>'
            ul.push '</ul>'
            ul.join('')

        @render view
      @get routeHandler 
           
    @nav = (routes) ->
      @includeRoute r, routes for r in routes
      
    app.apply(this)