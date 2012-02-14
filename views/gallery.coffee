@title = 'LJS - Gallery'
@longtitle = 'Gallery'
@description = 'Images taken of the work carried out by LJS Auto services in and around Swadlincote'
@introtext = 'A selection of images taken on (and sometimes off!) the job in and around the Swadlincote area.'
@stylesheets = [
  '/scripts/fancybox/jquery.fancybox-1.3.4'
  '/scripts/uploadify/uploadify'
  {inline:'''
    #fancybox-close {height:30px;}
    article a
    {
      display:inline-block;
      margin:0;
      overflow:hidden;
      padding:0 0 0 5px;
    }
    article img {height:75px;}

    text-shadow:2px 2px 2px white, -2px -2px 2px white, -2px 2px 2px white, 2px -2px 2px white}
  '''}
]
@scripts = [
  '/scripts/fancybox/jquery.fancybox-1.3.4.pack'
  '/scripts/uploadify/jquery.uploadify.min'
  '/scripts/uploadify/swfobject'
  '/viewsync'
  {inline:'''
  $(function(){
    function fancy(){
      $("a[rel=group]").fancybox({
       'transitionIn'		: 'none',
       'transitionOut'	: 'none',
       'titlePosition' 	: 'over',
       'titleFormat'		: function(title, currentArray, currentIndex, currentOpts) {
         return '<span id="fancybox-title-over">Image ' +
                 (currentIndex + 1) + ' / ' + currentArray.length + (title.length ? ' &nbsp; ' + title : '') + '</span>';
        }
      });
    };
    fancy();
    var newPics='';
    $('#file_upload').uploadify({
      'uploader'  : '/scripts/uploadify/uploadify.swf',
      'script'    : '/upload',
      'cancelImg' : '/scripts/uploadify/cancel.png',
      'scriptData'  : {'path':'gallery/'},
      'auto'      : true,
      'onComplete'  : function(event, ID, fileObj, response, data) {
        var t = "<a href='/images/gallery/{name}' rel='group'><img src='/images/gallery/{name}' class='last'></a>"
        var a = t.replace(/{name}/g,fileObj.name);
        if (!newPics) {
          var id = $("section article").length+1;
          $("section").append("<article id='"+id+"'></article>");
          newPics = $("#"+id);
        }
        newPics.append(a);
        fancy();
      }
    });
  });
  '''}
]

div -> input id:'file_upload', name:'file_upload', type:'file'

for x of @data
  article id:x.split('/')[1], ->
    @data[x].article