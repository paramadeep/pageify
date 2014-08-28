require 'spec_helper'

describe Pageify do
  before :each do
    base_dir = File.expand_path File.join __FILE__, '..', 'pages'
    @pageModule = Module.new.extend(Pageify)
    @pageModule.pageify base_dir
    @page = Class.new.send(:include, @pageModule).new
  end

  it "should have root" do
    expect(@page.root.selector).to eq(".root")
  end

  it "should heck for root params" do
    expect(@page.root("#id").simple.selector).to eq(".root #id .simple")
  end

  it "should have simple page" do
    expect(@page.root.simple.selector).to eq(".root .simple")
  end

  it "should have nested pages" do
    expect(@page.root.complex.selector).to eq(".root .complex")
    expect(@page.root.complex.nested.selector).to eq(".root .complex .nested")
  end

  it "should check arguments" do
    expect(@page.root.complex.arg(1).selector).to eq(".root .complex .arg:nth-of-type(1)")
  end

  it "should ignore arguments if not present" do
    expect(@page.root.complex.arg.selector).to eq(".root .complex .arg:nth-of-type()")
  end

  it "should check pages nested inside arguments" do
    expect(@page.root.complex.arg(1).arg_nested.selector).to eq(".root .complex .arg:nth-of-type(1) .arg_nested")
  end

  it "support multiple pages at the same time" do
    p1 = @page.root.simple
    p2 = @page.root.complex.nested

    expect(p1.selector).to eq(".root .simple")
    expect(p2.selector).to eq(".root .complex .nested")
  end

  it "should normalize whitespace" do
    expect(@page.root.complex.whitespace.selector).to eq(".root .complex .whitespace")
    expect(@page.root.complex.whitespace.whitespace_nested.selector).to eq(".root .complex .whitespace .whitespace_nested")
  end

  it "& should add to previous selector" do
    expect(@page.root.complex.nth(1).nth_variant.nth_nested.selector).to eq(".root .complex:nth-of-type(1).nth_variant .nth_nested")
  end

  it "should access sections mentioned" do
    expect(@page.root.complex.nth(1).details.name("seera").initial.letter.selector).to eq(".root .complex:nth-of-type(1) .first_section .name[name=seera] .initial #let")
  end

  it "should not scan sections as page objects" do
  end
end
