@title = 'LJS - Real Life Stories'
@longtitle = 'Real life stories from the kerbside'
@description = 'Stories about the life of a mobile mechanic out and about around Swadlincote and the east midlands area'
@introtext = 'Burst Brake Pipe Titanic Horror!'
@script = inline:'''
  $(function(){
  });
'''
@style = '''
  section {width:600px;font-size:1.3em;}
  .quote {color:gray;font-style:italic;padding-top:20px;}
  .customer {text-align:right;}
  article a {font-size:1em;}
  article p {padding-bottom:10px;}
  article img {float:right;width:250px;}
'''
@iehack = '''
'''

article ->
  p 'Called out the other day to fix the brakes on a Vauxhall Zafira - three days after Christmas and freezing cold outside.'
  img alt:'Freezing cold job', src:'/images/gallery/brakepipe/IMAG0046.jpg'

  p '''
    After inspecting the car I was horrified to see that two brake pipes had corroded and had burst independently of each other. 
    One failure I can understand but two at the same time? I scratched my head and resolved to research this at a later time. 
    I then replaced the brake pipes, bled the system and inspected for leaks.
  '''
  img alt:'Freezing cold job', src:'images/gallery/brakepipe/IMAG0042.jpg'

  p '''
    Job done and back home I investigated the performance of steel brake pipes under extreme cold conditions. 
    The problem is called Corrosion Fatigue and effects brake pipes where a combination of corrosion, 
    high pressure and extreme cold accelerates the failure of the pipe.
  '''

  p '''
    Put simply, the pipe cracks under braking pressure because the metal is brittle due to the cold and the 
    corrosion acts as a point of failure. The pipe does not have to be severely corroded. This is a similar 
    phenomenon to the tragic Titanic iceberg collision. The Titanic was brand new but the steel plates that 
    made up the hull were actually quite old and some had corroded around the rivets. The ice cold water and 
    the pressure of the iceberg ensured that the plates cracked just like the brake pipes in the car.
  '''

  p '''
    Luckily nobody died this time, but the moral of the story is quite clear: have your brake systems 
    thoroughly examined before the next cold snap.
  '''
  
  p ->
    a href:'http://en.wikipedia.org/wiki/Corrosion_Fatigue', ->
      text '(ref: http://en.wikipedia.org/wiki/Corrosion_Fatigue)'
