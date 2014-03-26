module Pageify
  require "pageify/page"
  require "pageify/string"
  require "pageify/page"
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

  def createPage(name)
    page = Page.new(name)
    define_method(name) do 
      $selector = ""
      page
    end
    page
  end

  def to_page_objects(file)
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
