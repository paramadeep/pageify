class PageObject
  include Capybara::DSL

  def f(*args)
    page.find(self.p, *args)
  end

  def find(*args)
    f(*args)
  end

  def all(*args)
    page.all(self.p, *args)
  end

  def []
    page.find(self.current_selector)
  end

  def method_missing(mtd_name, *args)
    page_element = page.find(self.current_selector)
    args.empty? ? page_element.send(mtd_name) : page_element.send(mtd_name, *args)
  end
end
