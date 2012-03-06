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

      cmdBar = $("<div id='cmdbar'><input id='file_upload' name='file_upload' type='file'><a href='#new'>New article</a><a href='#save'>Save this article</a><a href='#cancel'>Cancel</a></div>");
      cmdBar.hide().appendTo('body')
      savedRange=false
      saveSelection = ->
        if window.getSelection
          savedRange = window.getSelection().getRangeAt(0)
        else if document.selection #ie
          savedRange = document.selection.createRange()

      restoreSelection = (area) ->
        if !savedRange 
          area.focus()
          saveSelection()
        area.focus()
        if savedRange != null
          if window.getSelection
            s = window.getSelection()
            if s.rangeCount > 0 
                s.removeAllRanges()
            s.addRange(savedRange)
          else 
            if document.createRange
              window.getSelection().addRange(savedRange);
            else 
              if document.selection #ie
                savedRange.select()
                
        savedRange=false

      viewsync = new class
        edit: new class

          $('#file_upload').uploadify
            'uploader'  : '/scripts/uploadify/uploadify.swf'
            'script'    : '/upload'
            'cancelImg' : '/scripts/uploadify/cancel.png'
            'scriptData': 'path':'gallery/'
            'auto'      : true
            'onComplete':(event, ID, fileObj, response, data) ->
              onUpload(article,fileObj.name)
        
          left=37
          up=38
          right=39
          down=40
          inEdit=false
          article=null
          section=null
          empty=''
          root=$('body')[0].id

          toggle: (e) ->
            if e.altKey or inEdit

              e.preventDefault()

              if e.altKey
                
                if !inEdit
                  inEdit={}
                  saveSelection()
                  article=$(e.target).closest('article')
                  section = article.closest("section")
                  article.before cmdBar.show()
                else
                  inEdit=false
                  cmdBar.hide();
                  io.emit sync: {id:root+'/'+article[0].id,inner:article.html()} 

                @contentEdit inEdit!=false

              else
                inEdit[e.target.tagName]=$ e.target
        
          command: (e) ->
            switch e.target.href.split('#')[1]
              when "save"
                io.emit sync: {id:root+'/'+article[0].id,inner:article.html()} 
                @contentEdit false
                
              when "cancel"
                @contentEdit false                

              when "new"
                @contentEdit false
                id = section.find("article").length+1
                section.append articleTemplate id
                article = $("#"+id)
                empty = article.html()
                article.before cmdBar.show()
                $('html, body').animate({scrollTop:article.offset().top,500}, =>
                    @contentEdit true)

            return false;
            
          move: (e) ->
            if inEdit["IMG"] 
              float=false
              switch e.keyCode
                when left then float = {float:"left"}
                when right then float = {float:"right"}
                else inEdit={}
              if float
                inEdit["IMG"].css(float).focus().click()
                e.preventDefault()
                  
          upload: ->
            article.prepend($('#upload').show());
          
          contentEdit: (editable) ->
            article.attr("contentEditable",editable)
            if editable
              restoreSelection article
            else
              if article.html() == empty
                article.remove()
              inEdit=false
              cmdBar.hide()

      #events
      $('body').click (e) -> viewsync.edit.toggle e
      $('#cmdbar').click (e) -> viewsync.edit.command e
      $('body').keypress (e) -> viewsync.edit.move e
      
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
