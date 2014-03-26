require_relative "base_element"

class Page < BaseElement
  def initialize(name)
    @name = name
    $selector = ""
  end

end
