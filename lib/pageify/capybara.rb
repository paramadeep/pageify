class PageObject
  include Capybara::DSL

  def method_missing(mtd_name, *args)
    page_element = page.find(self.current_selector)
    args.empty? ? page_element.send(mtd_name) : page_element.send(mtd_name, *args)
  end

  def [](index)
    all()[index]
  end

  def all()
    page.find_all(self.current_selector)
  end
end
