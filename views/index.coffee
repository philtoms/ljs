@title = 'LJS - Car Servicing in Swadlincote'
@longtitle = 'Top notch servicing at your door'
@description = 'Top notch car servicing brought to your door in and around Swadlincote'
@introtext = 'With over 15 years experience in the industry we can service, repair or diagnose faults without you even having to leave your home or workplace.'
@script = inline:'''
$(function(){
  var quote=0;
  var pos = $("figure").position();

  $("#price p").hide().each(function(){
   var xy=$(this).attr("data-xy").split(",");
   $(this).css({position:"absolute",top:pos.top+parseInt(xy[1])+"px",left:pos.left+parseInt(xy[0])+"px"});
  });
  $("figure a").hover(
    function(){
      quote=$("#"+this.href.split("#")[1]);
      quote.show();
    },
    function(){quote.hide();}
  );
});
'''
@style = '''
#price p {
 padding:5px 15px 5px 5px;
 background-color:rgba(255,216,0,0.9);
 border:solid 2px yellow;
 font-size:1.5em;
}
#special{position:absolute;top:130px;left:840px;}
#price em {font-size:3em;padding-left:40px;color:red;display:block;
text-shadow:2px 2px 2px white, -2px -2px 2px white, -2px 2px 2px white, 2px -2px 2px white}
'''
@iehack = '''
/*http://kimili.com/journal/rgba-hsla-css-generator-for-internet-explorer/ */
#price p {background: transparent;-ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#E5FFD800,endColorstr=#E5FFD800)"; /* IE8 */    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#E5FFD800,endColorstr=#E5FFD800);   /* IE6 & 7 */      zoom: 1;}
'''
figure ->
  img src:"/images/yaris.gif", alt:"yaris"
  ul ->
    li ->
      a href:"#brakes", -> 'Brakes'
    li ->
      a href:"#cambelts", -> 'Cambelts'
    li ->
      a href:"#chipcode", -> 'Diagnostics'
    li ->
      a href:"#servicing", -> 'Servicing'
    li ->
      a href:"#battery", -> 'Batteries'

img id:"special", src:"./style/callnow.png", alt:"Call now on 07583338259"
div '#price', ->
  p id:"cambelts", 'data-xy':"350,200", -> 'Cambelts from <em>&pound;89</em>'
  p id:"brakes", 'data-xy':"80,200", -> 'Brakes from <em>&pound;39</em>'
  p id:"chipcode", 'data-xy':"400,100", -> 'Diagnostics from <em>&pound;20</em>'
  p id:"servicing", 'data-xy':"200,100", -> 'Servicing <em>&pound;49</em>'
  p id:"winter", 'data-xy':"100,100", -> 'Free Winter Checks<em>&pound;FREE</em>'
  p id:"battery", 'data-xy':"300,200", -> 'Batteries from <em>&pound;29.99</em>'
