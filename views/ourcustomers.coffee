@title = 'LJS - Satisfied Customers'
@longtitle = 'Comments from our customers'
@description = 'A selection of recommendations from our satisfied customer base in and around Swadlincote'
@introtext = 'LJS has only been operating a couple of months, but in that time we have already received several warm letters of appreciation of our services.'
@script = inline:'''
$(function(){
});
'''
@style = '''
  section {width:600px;font-size:1.3em;}
  .quote {color:gray;font-style:italic;padding-top:20px;}
  .customer {text-align:right;}
'''
@iehack = '''
'''

p 'With the kind permission of our customers, we are proud to present a selection of our recommendations here.'
p class:'quote', -> '&quot;I was very happy with the service and would use LJS again.&quot;'
p class:'customer', -> 'Mark Dennis, Belmont St, Swadlincote'
p class:'quote', -> '&quot;LJS were very helpful coming to my house in winter weather.&quot;'
p class:'customer', -> 'Karen Collins, Coppice Side, Swadlincote'
p class:'quote', -> '&quot;Not only have LJS done a tremendous job in keeping my Zafira safe and legal, but they have saved me hundreds of pounds into the bargain. I would not hesitate to recommend them.&quot'
p class:'customer', -> 'Philip Toms, Swadlincote'
p class:'quote'
p class:'customer'