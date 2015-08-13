class PageObject
  include Capybara::DSL

  def find(*args)
    page.find(selector,*args)
  end

  def all(*args)
    page.all(selector,*args)
  end

  def first(*args)
    page.first(selector,*args)
  end

  def with_text(text)
    page.find(selector,:text=>text)
  end

  def present?
    page.has_css? selector
  end

end
