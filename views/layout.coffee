doctype 5
html lang:'en', ->
  head ->
    meta charset:'utf-8'
    meta name:'description', content:@description
    meta name:'keywords', content:@keywords
    meta name:'google-site-verification', content:'XP3TLQI7dFpP_gMFBgpGcs0Xamm4ETkYNURfh7OPHwg'
    title @title if @title
    script src:'http://ajax.aspnetcdn.com/ajax/modernizr/modernizr-1.7-development-only.js'
    script src:'http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js'
    script src:'http:/socket.io/socket.io.js'
    script src: '/zappa/zappa.js'
    script src: '/viewsync.js'
    if @scripts
      for s in @scripts
        if typeof s is 'object'
            text "<script>#{s.inline}</script>" 
        else  
          script(src: s + '.js')
    if @script
      if typeof @script is 'object'
          text "<script>#{@script.inline}</script>" 
      else  
        script(src: @script + '.js')
    if @stylesheets
      for s in @stylesheets
        link rel: 'stylesheet', href: s + '.css'
    link(rel: 'stylesheet', href: @stylesheet + '.css') if @stylesheet
    style @style if @style
    if @iehack
      text '<!--[if lt IE 9]>'
      style @iehack
      text '<![endif]-->'

  body ->
    div id:'body', ->
      nav ->
        div "#{@nav()}"
        div id:'cred', ->
          a id:'twitter', href:'http://twitter.com/ljsautoservices', title:'LJS on Twitter', target:'_blank'
          a id:'facebook', href:'http://www.facebook.com/profile.php?id=100002604850094&sfrm', title:'LJS on Facebook', target:'_blank'
          a id:'snapon', href:'http://www.snapon.com', title:'Snapon tools', target:'_blank'
          a id:'ata', href:'http://www.automotivetechnician.org.uk/', title:'ATA', target:'_blank'
      header ->
        h1 @longtitle
        div @introtext if @introtext
      section ->
        @body
      footer '&copy; 2012 PTS Systems Ltd'
      script src: @tailscript + '.js' if @tailscript
