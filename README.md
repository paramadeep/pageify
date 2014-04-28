#Pageify

[![Code Climate](https://codeclimate.com/github/paramadeep/pageify.png)](https://codeclimate.com/github/paramadeep/pageify)    [![Dependency Status](https://gemnasium.com/paramadeep/pageify.svg)](https://gemnasium.com/paramadeep/pageify)  [![Build Status](https://travis-ci.org/paramadeep/pageify.svg?branch=master)](https://travis-ci.org/paramadeep/pageify)

Lets you define page objects for your UI tests, written in Ruby. 

##Example

Page definition looks like this
```yaml
home_page: ".home"
  login: "div.login"
    user_name: "input.user"
    password: "input.password"
    submit: "[name='submit']"
  profile_name: "a.profile"
  settings: "a.settings"
  sign_up: "a.sign_up"
```
Test steps looks like this
```ruby
fill_in home_page.login.user_name :with => "hi"
fill_in home_page.login.password :with => "bla"
click_on home_page.login.submit

home_page.profile_name.should match_text "hi"
hoem_pafe.settings.should be_visible
```
    
## Key benefits

- Your test will be more **readable**.
- **Eliminates duplicate** definition of selectors across test.
- **Easy Maintenance**.

## Usage
In your project Gemfile add 
```ruby
gem 'pageify'
```
###Cucumber
 In env.rb
 ```ruby
 include Pageify
 pageify("features/pages")
 ```
 Place all the page defenitions under "features/pages"

