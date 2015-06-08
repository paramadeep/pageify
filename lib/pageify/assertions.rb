module Assertions
  extend RSpec::Matchers::DSL

  matcher :match_text do |expected_text|
    match_for_should {  |node|  node.has_text?(/^#{expected_text.escape_specials}$/) }
    failure_message_for_should { |node| "expected #{expected_text} but was '#{node.text}'"}
    match_for_should_not { |node| node.has_no_text?(/^#{text.escape_specials}$/) }
  end

  matcher :match do |expected|
    match_for_should do |node|
      case node.tag_name 
      when "select"
        node.should have_selected expected 
      when "input"
        node.value.should eq expected
      when "textArea"
        node.value.should eq expected
      else
        node.has_text?(/^#{expected.escape_specials}$/)
      end
    end
    failure_message_for_should do |node|
      actual = ""
      case node.tag_name 
      when "select"
        actual = node.text
      when "input"
        actual = node.value
      when "textArea"
        actual = node.value
      else
        actual = node.text
      end
      "expected #{expected} but was '#{actual}'"
    end
  end

  matcher :have_selected do |text|
    match_for_should do |node|
      node.find("option[selected='']").has_text?(/^#{text}/)
    end
  end

  matcher :have_selected_percentage do |text|
    match_for_should do |node|
      value = node.value
      node.find("option[value='#{value}']").has_text?(/^#{text}/)
    end
  end

  matcher :be_disabled do 
    match_for_should do |node| 
      (node['disabled'] == "true" or node['class'].include? "disabled").should eq true
    end
    failure_message_for_should { |node| "expected #{node.to_s} to be disabled but was enabled"}
  end

  matcher :be_checked do
    match_for_should do |node|
      (node['checked'] == "true" or node['class'].include? "checked").should eq true
    end
    failure_message_for_should { |node| "expected #{node.to_s} to be checked but not checked"}
  end

  matcher :not_be_checked do
    match_for_should do |node|
      (node['checked'] == "false" or !node['class'].include? "checked").should eq true
    end
    failure_message_for_should { |node| "expected #{node.to_s} not to be checked but was checked"}
  end

  matcher :be_enabled do
    match_for_should { |node| node['disabled'].should be_nil }
    failure_message_for_should { |node| "expected #{node.to_s} to be enabled but was disabled"}
  end

  matcher :have_validation_error do
    match_for_should {|node| node['class'].include? "error" }
  end

  matcher :exist do
    match_for_should_not {|node| page.has_no_css? node.selector}
  end
end
