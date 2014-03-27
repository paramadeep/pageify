module Pageify
  require "pageify/string"
  require "pageify/element"

  def pageify(base_dir)
    base_dir.chomp! '/'
    all_pages = []
    Dir["#{base_dir}/**/"].each do |dir|
      Dir["#{dir}*.page"].each do |file|
        to_page_objects file
      end
    end
  end

  def createElement(name,selector)
    element = Element.new(name,selector,nil)
    define_method("_#{name}") do 
      $selector = ""
      element
    end
    element
  end

  def to_page_objects(file)
    rawArray = IO.read(file).split("\n").map{|x| x.rstrip}
    rawArray -= [""]
    parentElement = rawArray.shift
    page = createElement(parentElement.name,parentElement.selector)
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
