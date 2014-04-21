require 'spec_helper'

describe Pageify do
  before :each do
    base_dir = File.expand_path File.join __FILE__, '..', 'pages'
    @pageModule = Module.new.extend(Pageify)
    @pageModule.pageify base_dir
    @page = Class.new.send(:include, @pageModule).new
  end

  it "should have root" do
    @page.root.p.should == ".root"
  end

  it "should have simple page" do
    @page.root.simple.p.should == ".root .simple"
  end

  it "should have nested pages" do
    @page.root.complex.p.should == ".root .complex"
    @page.root.complex.nested.p.should == ".root .complex .nested"
  end

  it "should check arguments" do
    @page.root.complex.arg(1).p.should == ".root .complex .arg:nth-of-type(1)"
  end

  it "should check pages nested inside arguments" do
    @page.root.complex.arg(1).arg_nested.p.should == ".root .complex .arg:nth-of-type(1) .arg_nested"
  end

  it "should correctly resolve multiple pages" do
    p1 = @page.root.simple
    p2 = @page.root.complex.nested

    p1.p.should == ".root .simple"
    p2.p.should == ".root .complex .nested"
  end
end
