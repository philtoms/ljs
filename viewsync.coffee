@include = ->

  @on 'connection': ->
    console.log 'connect' 
 
  store = @store
  @on sync: ->
    data = @data
    store.get @data.id, (e,d,k) ->
      if !d || d.article!=data.inner
        store.save data.id,{article:data.inner},->
          console.log "updated " + data.id

  @client '/viewsync.js': ->
    @connect()
    
    $ =>
      inEdit=false
      target=null
      root=$('body')[0].id
      $('body').click (e) =>
        if e.altKey or inEdit

          e.preventDefault()

          if e.altKey
            
            if inEdit=!inEdit
              target=$(e.target).closest('article')
            else
              @emit sync: {id:root+'/'+target[0].id,inner:target.html()} 

            target.attr("contentEditable",inEdit) 
        
  @client '/uploadify.js': ->
    $ ->
      newPics='';
      $('#file_upload').uploadify
        'uploader'  : '/scripts/uploadify/uploadify.swf'
        'script'    : '/upload'
        'cancelImg' : '/scripts/uploadify/cancel.png'
        'scriptData': 'path':'gallery/'
        'auto'      : true
        'onComplete':(event, ID, fileObj, response, data) ->
          t = "<a href='/images/gallery/{name}' rel='group'><img src='/images/gallery/{name}' class='last'></a>"
          a = t.replace(/{name}/g,fileObj.name);
          if (!newPics)
            id = $("section article").length+1;
            $("section").append("<article id='"+id+"'></article>");
            newPics = $("#"+id);
          
          newPics.append(a);n
          $.ext.fancybox();
