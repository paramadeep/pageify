class PageObject
  attr_accessor :name,:parent,:self_selector,:intend,:full_selector

  def createChild (raw_row)
    child = PageObject.create(raw_row)
    child.parent = self
    define_singleton_method(child.name) do |*arguments|
      unless arguments.eql? []
        child_selector = (child.self_selector % arguments).strip_quotes.strip
      else
        child_selector = (child.self_selector % '').strip_quotes.strip
      end
      if child_selector.start_with? "&"
        child.full_selector = @full_selector + child_selector.gsub(/^&/, "")
      else
        child.full_selector = @full_selector + " " + child_selector
      end
      child
    end
    return child
  end

  def self.create (raw_row)
    name = raw_row.lstrip.split(":").first
    self_selector = raw_row.slice(raw_row.index(':')+1..-1)
    intend = raw_row.lspace
    PageObject.new(name,self_selector,intend)
  end

  def selector
    @full_selector.strip
  end

  def initialize (name,self_selector,intend)
    @name = name
    @self_selector = self_selector
    @intend = intend
  end

end
