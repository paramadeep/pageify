require "capybara"
require "capybara/rspec"

class PageObject
  include Capybara::DSL
  include Assertions
  include Capybara::RSpecMatchers

  def find(*args)
    page.find(self.selector,*args)
  end

  def find_all(*args)
    page.all(self.selector,*args)
  end

  def should_match_fields fields
    if fields.is_a?(Hash)
      match_fields fields
    else
      fields.hashes.each do |field|
        match_fields field 
      end
    end
  end

  def should_have_enabled fields 
    process_fields(fields,Proc.new{|field| get_child(field).find.should be_enabled})
  end

  def should_have_disabled fields 
    process_fields(fields,Proc.new{|field| get_child(field).find.should be_disabled})
  end

  def should_not_have fields
    process_fields(fields,Proc.new{|field|page.should_not have_css get_selector(field)})
  end

  def click_on child
    get_child(child).find.click 
    self
  end

  def set_fields children_with_values_as_hash
    children_with_values_as_hash.each do |key,value|
      get_child(key).set value
    end
    self
  end 

  def run_block (&block)
    @self_before_instance_eval = eval "self", block.binding
    instance_eval &block
  end

  private
  def match_fields field 
    field.each do|key,value|
      element = page.find(get_selector(key))
      if element.tag_name == 'input' && element[:type] == 'checkbox'
        value == 'true' ? element.should(be_checked) : element.should_not(be_checked)
      else
        element.should match value
      end
    end
  end

  def process_fields fields,block 
    fields = fields.is_a?(Array) ? fields : fields.raw.map{|x|x[0]}
    fields.each do |field|
      block.call(field)
    end
  end

  def get_selector children
    get_child(childeren).selector
  end

  def get_child children 
    children = children.to_s.gsub(" ","").underscore
    child_object = self
    children.split('.').each do |child|
      method_name = child.split('(')[0]
      arguments = child.split('(')[1].chomp(')').split(',') if child.include? '('
      child_object = arguments.present? ? child_object.send(method_name,*[*arguments]) : child_object.send(child)
    end
    child_object
  end

end
