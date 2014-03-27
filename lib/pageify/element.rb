class Element 
  attr_accessor :name,:parent,:selector

  def createChild (name,selector)
    child = Element.new(name,selector,self)
    define_singleton_method(name) do |*arguments|
      $selector += selector % arguments
      child
    end
    return child
  end

  def p
    $selector.gsub("\"","").strip
  end

  def initialize (name,selector,parent)
    @name = name
    @selector = selector
    @parent = parent
  end

end
