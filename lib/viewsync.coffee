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
    io = this
    @connect()
    $ ->
      viewsync = new class
        edit: new class

          $('#file_upload').uploadify
            'uploader'  : '/scripts/uploadify/uploadify.swf'
            'script'    : '/upload'
            'cancelImg' : '/scripts/uploadify/cancel.png'
            'scriptData': 'path':'gallery/'
            'auto'      : true
            'onComplete':(event, ID, fileObj, response, data) ->
              $('#upload').hide()
              t = "<a href='/images/gallery/{name}' rel='group'><img src='/images/gallery/{name}' class='last'></a>"
              a = t.replace(/{name}/g,fileObj.name);
              article.prepend a
        
          left=37
          up=38
          right=39
          down=40
          inEdit=false
          article=null
          root=$('body')[0].id

          toggle: (e) ->
            if e.altKey or inEdit

              e.preventDefault()

              if e.altKey
                
                if !inEdit
                  inEdit={}
                  article=$(e.target).closest('article')
                else
                  inEdit=false
                  io.emit sync: {id:root+'/'+article[0].id,inner:article.html()} 

                article.attr("contentEditable",inEdit!=false)

              else
                inEdit[e.target.tagName]=$ e.target
                console.log inEdit[e.target.tagName]
        
          command: (e) ->
            if inEdit
              if e.ctrlKey && e.charCode==102
                @upload()
                
              console.log e
              if inEdit["IMG"] 
                float=false
                switch e.keyCode
                  when left then float = {float:"left",paddingRight:"5px"}
                  when right then float = {float:"right",paddingLeft:"5px"}
                  else inEdit={}
                if float
                  inEdit["IMG"].css(float).focus().click()
                  e.preventDefault()
                  
          upload: ->
            article.prepend($('#upload').show());
              
      #events
      $('body').click (e) -> viewsync.edit.toggle e
      $('body').keypress (e) -> viewsync.edit.command e
  
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
          
          newPics.append a
          $.ext.fancybox();
