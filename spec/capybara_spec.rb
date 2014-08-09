require 'capybara/dsl'
require "pageify/capybara"
require 'spec_helper'

describe Capybara do
  before :each do
    base_dir = File.expand_path File.join __FILE__, '..', 'pages'
    @pageModule = Module.new.extend(Pageify)
    @pageModule.pageify base_dir
    @page = Class.new.send(:include, @pageModule).new
    @dummy_page = double('dummy_page')
  end

  it "should select the element in the page" do
    mock_selected = double('mock selected')
    expect(@page.root.simple).to receive(:page).and_return(@dummy_page).twice
    expect(@dummy_page).to receive(:find).with('.root .simple').and_return(mock_selected).twice
    expect(mock_selected).to receive(:set).with('something')
    expect(mock_selected).to receive(:click)
    expect(@page.root.simple.set('something'))
    expect(@page.root.simple.click)
  end
end
