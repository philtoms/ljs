@title = 'LJS - Real Life Stories'
@longtitle = 'Real life stories from the kerbside'
@description = 'Stories about the life of a mobile mechanic out and about around Swadlincote and the east midlands area'

@style = '''
  section {width:600px;font-size:1.3em;}
  .quote {color:gray;font-style:italic;padding-top:20px;}
  .customer {text-align:right;}
  article header {padding:5px 0;}
  article a {font-size:1em;}
  article p {padding-bottom:10px;}
  article img {float:right;width:250px;}
'''

for x of @data
  article id:x.split('/')[1], ->
    @data[x].article