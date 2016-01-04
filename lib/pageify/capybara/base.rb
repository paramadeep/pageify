require 'capybara'
module Pageify

  def set_session(session_page)
    @@session = session_page 
  end

  def get_session
    @@session
  end 

  class PageObject

    def find(*args)
      get_session.find(selector,*args)
    end

    node_methods = Capybara::Node::Element.instance_methods - Object.methods - instance_methods - [:click_on]
    (node_methods).each do |node_method| 
      define_method (node_method)  do |*arguments|
        self.find.send(node_method,*arguments)
      end
    end

    def all(*args)
      page.all(selector,*args)
    end

    alias :find_all :all

    def first(*args)
      page.first(selector,*args)
    end

    def with_text(text)
      page.find(selector,:text=>text)
    end
  end
end
