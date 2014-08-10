class PageObject
  include Capybara::DSL

  (Capybara::Driver::Node.public_instance_methods - Object.public_instance_methods ).each do |method|
    define_method method do |*args| 
      page_element = page.find(self.selector)
      args.empty? ? page_element.send(method) : page_element.send(method,*args) 
    end 
  end 

  def find_all()
    page.all(self.selector)
  end
end
