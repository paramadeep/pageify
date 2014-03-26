require 'pry'
require_relative "string"
require_relative "page"
require_relative "element"

def createPage(name)
  page = Page.new(name)
  define_method(name) do 
    $selector = ""
    page
  end
  page
end

class Parse
  def self.to_page_objects(file)
    rawArray = IO.read(file).split("\n").map{|x| x.rstrip}
    rawArray -= [""]
    page = createPage(rawArray.shift.name)
    parent = [page]
    until rawArray.empty? do
      thisElement = rawArray.first
      nextElement = rawArray[1]
      until parent.last.name().lspace < thisElement.lspace do 
        parent.pop
      end
      element = parent.last.createChild(thisElement.name,thisElement.selector)
      rawArray.shift
      parent << element if rawArray.any? &&thisElement.lspace < nextElement.lspace
    end
  end
end
