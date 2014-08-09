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
end
