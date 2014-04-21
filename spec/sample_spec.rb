require 'spec_helper'

describe Pageify do
  before :each do
    base_dir = File.expand_path File.join __FILE__, '..', 'pages'
    @pageModule = Module.new.extend(Pageify)
    @pageModule.pageify base_dir
    @page = Class.new.send(:include, @pageModule).new
  end

  it "should have root" do
    @page.login_page.p.should be_empty
  end

  it "should have sub element" do
    @page.login_page.login.p.should == ".div"
  end
end
