require "pageify/capybara"
class PageObject
  (Capybara::Selenium::Node.instance_methods - Object.methods).each do |node_method| 
    define_method (node_method)  do |*arguments|
      self.find.send(node_method,*arguments)
    end
  end

end

def on (pageObject,&block)
  pageObject.run_block &block
end
