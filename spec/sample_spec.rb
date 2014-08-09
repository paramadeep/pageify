require 'spec_helper'

describe Pageify do
  before :each do
    base_dir = File.expand_path File.join __FILE__, '..', 'pages'
    @pageModule = Module.new.extend(Pageify)
    @pageModule.pageify base_dir
    @page = Class.new.send(:include, @pageModule).new
  end

  it "should have root" do
    expect(@page.root.current_selector).to eq(".root")
  end

  it "should heck for root params" do
    expect(@page.root("#id").simple.current_selector).to eq(".root #id .simple")
  end

  it "should have simple page" do
    expect(@page.root.simple.current_selector).to eq(".root .simple")
  end

  it "should have nested pages" do
    expect(@page.root.complex.current_selector).to eq(".root .complex")
    expect(@page.root.complex.nested.current_selector).to eq(".root .complex .nested")
  end

  it "should check arguments" do
    expect(@page.root.complex.arg(1).current_selector).to eq(".root .complex .arg:nth-of-type(1)")
  end

  it "should ignore arguments if not present" do
    expect(@page.root.complex.arg.current_selector).to eq(".root .complex .arg:nth-of-type()")
  end

  it "should check pages nested inside arguments" do
    expect(@page.root.complex.arg(1).arg_nested.current_selector).to eq(".root .complex .arg:nth-of-type(1) .arg_nested")
  end

  it "does not support multiple pages at the same time" do
    p1 = @page.root.simple
    p2 = @page.root.complex.nested

    expect(p1.current_selector).to eq(".root .complex .nested")
    expect(p2.current_selector).to eq(".root .complex .nested")
  end

  it "should normalize whitespace" do
    expect(@page.root.complex.whitespace.current_selector).to eq(".root .complex .whitespace")
    expect(@page.root.complex.whitespace.whitespace_nested.current_selector).to eq(".root .complex .whitespace .whitespace_nested")
  end

  it "& should add to previous selector" do
    expect(@page.root.complex.nth(1).nth_variant.nth_nested.current_selector).to eq(".root .complex:nth-of-type(1).nth_variant .nth_nested")
  end

  it "should access sections mentioned" do
    expect(@page.root.complex.nth(1).details.name("seera").initial.letter.current_selector).to eq(".root .complex:nth-of-type(1) .first_section .name[name=seera] .initial #let")
  end

  it "should not scan sections as page objects" do
  end
end
