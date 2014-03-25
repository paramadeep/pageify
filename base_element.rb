$selector
class BaseElement
  attr_accessor :name,:parent
  def createChild (name,selector)
    child = Element.new(name,selector,self)
    define_singleton_method(name) do 
      $selector += selector
      child
    end
    return child
  end

  def build
    $selector.gsub("\"","")
  end
end

