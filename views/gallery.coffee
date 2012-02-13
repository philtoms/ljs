@title = 'LJS - Gallery'
@longtitle = 'Gallery'
@description = 'Images taken of the work carried out by LJS Auto services in and around Swadlincote'
@introtext = 'A selection of images taken on (and sometimes off!) the job in and around the Swadlincote area.'
@stylesheets = [
  '/scripts/fancybox/jquery.fancybox-1.3.4'
  '/scripts/uploadify/uploadify'
]
@scripts = [
  '/scripts/fancybox/jquery.fancybox-1.3.4.pack',
  '/scripts/uploadify/jquery.uploadify.min'
  '/scripts/uploadify/swfobject'
  {inline:'''
  $(function(){
    $("a[rel=group]").fancybox({
     'transitionIn'		: 'none',
     'transitionOut'	: 'none',
     'titlePosition' 	: 'over',
     'titleFormat'		: function(title, currentArray, currentIndex, currentOpts) {
       return '<span id="fancybox-title-over">Image ' +
               (currentIndex + 1) + ' / ' + currentArray.length + (title.length ? ' &nbsp; ' + title : '') + '</span>';
      }
    });
    $('#file_upload').uploadify({
      'uploader'  : '/scripts/uploadify/uploadify.swf',
      'script'    : '/upload',
      'cancelImg' : '/scripts/uploadify/cancel.png',
      'scriptData'  : {'firstName':'Ronnie','age':30},
      'auto'      : true,
      'onComplete'  : function(event, ID, fileObj, response, data) {
        console.log(fileObj);
        console.log(response);
        console.log(data);
      }
    });
  });
  '''}
]
@style = '''
#fancybox-close {height:30px;}
.last {height:75px;}
article a
{
display:inline-block;
height:75px;
margin:0;
overflow:hidden;
padding:0 0 0 5px;
width:75px;
}
text-shadow:2px 2px 2px white, -2px -2px 2px white, -2px 2px 2px white, 2px -2px 2px white}
'''

div -> input id:'file_upload', name:'file_upload', type:'file'

a title:'Code Check', rel:'group', href:'/images/gallery/IMAG0021.jpg', -> img class:'last', src:'/images/gallery/IMAG0021_s.jpg', alt:'Code Check'
a title:'The Van', rel:'group', href:'/images/gallery/IMAG0019.jpg', -> img class:'last', src:'/images/gallery/IMAG0019_s.jpg', alt:'The Van'
h3 'Brakes'
a title:'Brakes', rel:'group', href:'/images/gallery/brakes/18112010137.jpg', -> img class:'last', src:'/images/gallery/brakes/18112010137_s.jpg'
a title:'Brakes', rel:'group', href:'/images/gallery/brakes/18112010138.jpg', -> img class:'last', src:'/images/gallery/brakes/18112010138_s.jpg'
a title:'Brakes', rel:'group', href:'/images/gallery/brakes/18112010139.jpg', -> img class:'last', src:'/images/gallery/brakes/18112010139_s.jpg'
a title:'Brakes', rel:'group', href:'/images/gallery/brakes/18112010140.jpg', -> img class:'last', src:'/images/gallery/brakes/18112010140_s.jpg'
a title:'Brakes', rel:'group', href:'/images/gallery/brakes/18112010141.jpg', -> img class:'last', src:'/images/gallery/brakes/18112010141_s.jpg'
a title:'Brakes', rel:'group', href:'/images/gallery/brakes/18112010142.jpg', -> img class:'last', src:'/images/gallery/brakes/18112010142_s.jpg'
a title:'Brakes', rel:'group', href:'/images/gallery/brakes/18112010143.jpg', -> img class:'last', src:'/images/gallery/brakes/18112010143_s.jpg'
a title:'Brakes', rel:'group', href:'/images/gallery/brakes/18112010144.jpg', -> img class:'last', src:'/images/gallery/brakes/18112010144_s.jpg'
h3 'Rusty Brake Pipes'
a rel:'group', href:'/images/gallery/brakepipe/IMAG0041.jpg', -> img class:'last', src:'/images/gallery/brakepipe/IMAG0041s.jpg'
a rel:'group', href:'/images/gallery/brakepipe/IMAG0042.jpg', -> img class:'last', src:'/images/gallery/brakepipe/IMAG0042s.jpg'
a rel:'group', href:'/images/gallery/brakepipe/IMAG0043.jpg', -> img class:'last', src:'/images/gallery/brakepipe/IMAG0043s.jpg'
a rel:'group', href:'/images/gallery/brakepipe/IMAG0044.jpg', -> img class:'last', src:'/images/gallery/brakepipe/IMAG0044s.jpg'
a rel:'group', href:'/images/gallery/brakepipe/IMAG0045.jpg', -> img class:'last', src:'/images/gallery/brakepipe/IMAG0045s.jpg'
a rel:'group', href:'/images/gallery/brakepipe/IMAG0046.jpg', -> img class:'last', src:'/images/gallery/brakepipe/IMAG0046s.jpg'
a rel:'group', href:'/images/gallery/brakepipe/IMAG0047.jpg', -> img class:'last', src:'/images/gallery/brakepipe/IMAG0047s.jpg'