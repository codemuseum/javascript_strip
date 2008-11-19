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
      
      # strip javascript: and java\nscript in href ...
      doc.search("[@href*='javascript:']").each do |e|
        e.remove_attribute "href"
        e.set_attribute("href", "")
      end
      doc.search("[@href*='java\nscript:']").each do |e|
        e.remove_attribute "href"
        e.set_attribute("href", "")
      end
      # ... and style attributes
      doc.search("[@style*='javascript:']").each do |e|
        e.remove_attribute "style"
        e.set_attribute("style", "")
      end
      doc.search("[@style*='java\nscript:']").each do |e|
        e.remove_attribute "style"
        e.set_attribute("style", "")
      end

      doc.to_s
   end
  end
end
