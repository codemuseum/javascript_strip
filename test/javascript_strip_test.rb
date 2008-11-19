require 'test/unit'
require 'lib/javascript_strip'

class JavascriptStripTest < Test::Unit::TestCase
  def test_strip
    ## example html includes or invokes javascript in three ways:
    ## 1. href=javascript:function()
    ## 2. <script> tags
    ## 3. event handler attributes (onclick, onmouseover ...)
    html= "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"
        \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">
<head>
<meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\" />
<link rel=\"alternate\" type=\"application/xml\" href=\"/somepath\" />
<title>A title</title>

<!--   
A comment
-->
<script type=\"text/javascript\" src=\"jquery-1.2.6.min.js\"></script>
</head>
<body>

<h1>Welcome to the show</h1>

<div>
<a href=\"javascript:function() {}; return false;\">afadsfasd</a>
<a href=\"javascript:function() {}; return false;\">afadsfasd</a>
</div>

<script>
asfsafsafdasdf
asdfasdfasd
asfasfasdfasdf
asfasdfsadf
</script>
<script>
asfsafsafdasdf
asdfasdfasd
asfasfasdfasdf
asfasdfsadf
</script>

<div>
<span><a href=\"\" ondblclick=\"function() {};\"></a></span>
<a href=\"\" onclick=\"function() {};\"></a>
<a href=\"\" onmouseover=\"function() {};\"></a>
</div>

<a href=\"java\nscript:function() {}\">java\nscript in href</a>
<div style=\"backgrpund(java\nscript:function() {})\">java\nscript in style</a>

<table>
<tr><td>Hola Mundo!</td></tr>
</table>
</body>
</html>"
    
    expected_html="<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<head>\n<meta content=\"text/html; charset=utf-8\" http-equiv=\"content-type\" />\n<link href=\"/somepath\" rel=\"alternate\" type=\"application/xml\" />\n<title>A title</title>\n\n<!--   \nA comment\n-->\n\n</head>\n<body>\n\n<h1>Welcome to the show</h1>\n\n<div>\n<a href=\"\">afadsfasd</a>\n<a href=\"\">afadsfasd</a>\n</div>\n\n\n\n\n<div>\n<span><a href=\"\"></a></span>\n<a href=\"\"></a>\n<a href=\"\"></a>\n</div>\n\n<a href=\"\">java\nscript in href</a>\n<div style=\"\">java\nscript in style\n\n<table>\n<tr><td>Hola Mundo!</td></tr>\n</table>\n</div></body>\n"
    jss = Javascript::Strip.new(html)
    jsstripped_html=jss.strip
    assert_equal(expected_html, jsstripped_html)
  end
end
