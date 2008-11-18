require 'test/unit'
require 'lib/javascript_strip'

class JavascriptStripTest < Test::Unit::TestCase
  def test_strip
    ## example html includes or invokes javascript in three ways:
    ## 1. href=javascript:function()
    ## 2. <script> tags
    ## 3. event handler attributes (onclick, onmouseover ...)
    html= "<a href=\"javascript:function() {}; return false;\">afadsfasd</a>
<a href=\"javascript:function() {}; return false;\">afadsfasd</a>
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
<a href="" ondblclick=\"function() {};\"></a>
<a href="" onclick=\"function() {};\"></a>
<a href="" onmouseover=\"function() {};\"></a>"
    
    expected_html="<a href=\"\">afadsfasd</a><a href=\"\">afadsfasd</a>\n\n\n<a href=\"\"></a>\n<a href=\"\"></a>\n<a href=\"\"></a>"
    
    jss = Javascript::Strip.new(html)
    jsstripped_html=jss.strip
    assert_equal(expected_html, jsstripped_html)
  end
end
