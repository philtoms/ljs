@include = ->

  @client '/viewsync.js': ->
    @connect()
    
    $ =>
      inEdit=false
      target=null
      $('body').click (e) =>
        if e.altKey or inEdit
          e.preventDefault()
          if e.altKey
            
            if inEdit=!inEdit
              target=$(e.target).closest('article')
            else
              @emit sync: {id:target[0].id,inner:target.html()} 

            target.attr("contentEditable",inEdit) 
        
  @on 'connection': ->
    console.log 'connect' 
 
  store = @store
  @on sync: ->
    data = @data
    store.get @data.id, (e,d,k) ->
      if d.article!=data.inner
        store.save data.id,{article:data.inner},->
          console.log "updated " + data.id
