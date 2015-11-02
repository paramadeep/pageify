require 'pageify/capybara/base'
describe Pageify do
  before :each do
    base_dir = File.expand_path File.join __FILE__, '..', 'pages'
    @test_page_module = Module.new.extend(Pageify)
    @test_page_module.pageify base_dir
    @test_page = Class.new.send(:include, @test_page_module).new
  end

  it "should include node methods of capybara" do
    expect(@test_page.root.methods).to include(*(Capybara::Node::Element.instance_methods - Object.methods))
  end

  it "should redirect relevant methods to capybara elemnt method" do
    session = instance_double("Capybara::Session")
    capybara_element = instance_double("Capybara::Node::Element")
    allow(session).to receive(:find).with(".root").and_return(capybara_element)
    allow(capybara_element).to receive(:value).and_return(10)
    set_session(session) 
    expect(@test_page.root.value).to equal(10) 
  end
end
