class PageObject
  attr_accessor :name,:parent,:selector,:intend

  def createChild (raw_row)
    child = PageObject.create(raw_row)
    child.parent = self
    define_singleton_method(child.name) do |*arguments|
      $selector += child.selector % arguments
      child
    end
    return child
  end

  def self.create (raw_row)
    name = raw_row.lstrip.split(":").first
    selector = raw_row.slice(raw_row.index(':')+1..-1)
    intend = raw_row.lspace
    PageObject.new(name,selector,intend)
  end

  def p
    $selector.gsub("\"","").strip
  end

  def initialize (name,selector,intend)
    @name = name
    @selector = selector
    @intend = intend
  end

end
