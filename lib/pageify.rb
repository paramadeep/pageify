module Pageify
  require "pageify/string"
  require "pageify/page_object"
  require "pageify/assertions"
  require "pageify/page_object_ext"

  def pageify(base_dir)
    base_dir = Dir.pwd + "/" + base_dir
    base_dir.chomp! '/'
    all_pages = []
    (Dir["#{base_dir}/**/*.yml"]-Dir["#{base_dir}/**/_*.yml"]).each do |file|
      to_page_objects file
    end
  end

  def createElement(raw_row)
    element = PageObject.create(raw_row)
    define_method(element.name) do |*arguments|
      unless arguments.eql? []
        element.full_selector = (element.self_selector % arguments).strip_quotes.strip
      else
        element.full_selector = (element.self_selector % '').strip_quotes.strip
      end
      element
    end
    element
  end

  def replace_sections (parent_array,file)
    processed_parent = []
    parent_array.each do |row|
      if row.lstrip.start_with?":"
        section_file = "#{File.dirname (file)}/#{row.split(':')[1]}.yml"
        section_file = "#{File.dirname(section_file)}/_#{File.basename(section_file)}"
        section_array =  get_procesed(section_file)
        section_array.each_with_index do |value,index|
          section_array[index] = " " * row.lspace + value
        end
        processed_parent =  processed_parent + section_array
      else
        processed_parent =  processed_parent + [row]
      end
    end
    processed_parent
  end

  def get_procesed (file)
    rawArray= IO.read(file).split("\n").map{|x| x.rstrip}
    rawArray -= [""]
    rawArray = replace_sections(rawArray,file)
  end

  def to_page_objects(file)
    rawArray = get_procesed(file)
    parentElement = rawArray.shift
    page = createElement(parentElement)
    parent = [page]
    until rawArray.empty? do
      thisElement = rawArray.first
      nextElement = rawArray[1]
      until parent.last.intend < thisElement.lspace do
        parent.pop
      end
      element = parent.last.createChild(thisElement)
      rawArray.shift
      parent << element if rawArray.any? &&thisElement.lspace < nextElement.lspace
    end
  end
end
include Pageify
