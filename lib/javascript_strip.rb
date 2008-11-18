# Usage: 
require 'rubygems'
require 'hpricot'

module Javascript
  class Strip
    attr_reader :html
    
    HTML_EVENT_HANDLERS=%w{onload onunload onchange onsubmit onreset onselect onblur onfocus onkeydown onkeypress onkeyup onclick ondblclick onmousedown onmouseover onmouseout onmouseup}
    
    def initialize(html)
      @html=html
    end
    
    def strip
      doc=Hpricot(@html)
      
      # strip onxxx attributes
      HTML_EVENT_HANDLERS.each do |h|
        doc.search("[@#{h}]").each { |e| e.remove_attribute h }
      end
      
      # strip <script> inclusions
      doc.search("script").remove
      
      # strip javascript: in href attribute
      doc.search("[@href^='javascript:']").each do |e|
        e.remove_attribute "href"
        e.set_attribute("href", "")
      end
 
      doc.to_s
   end
  end
end
