require_relative "base_element"

class Element < BaseElement
  attr_accessor :parent

  def initialize (name,selector,parent)
    @name = name
    @selector = selector
    @parent = parent
  end
end
