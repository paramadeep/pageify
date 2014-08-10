class PageObject
  include Capybara::DSL

  def find()
    page.find(self.selector)
  end

  def f()
    self.find
  end

  def find_all()
    page.all(self.selector)
  end
end
