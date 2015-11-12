# Pageify

[![Code Climate](https://codeclimate.com/github/paramadeep/pageify.png)](https://codeclimate.com/github/paramadeep/pageify)    [![Dependency Status](https://gemnasium.com/paramadeep/pageify.svg)](https://gemnasium.com/paramadeep/pageify)  [![Build Status](https://travis-ci.org/paramadeep/pageify.svg?branch=master)](https://travis-ci.org/paramadeep/pageify)

Simplest way to define page objects. Bonus, tremendously fast tests.

##Example

Page definition looks like this
```yaml
# sign_up_page.yml 
sign_up: ".home"
    user_name: ".user"
    password: ".password"
    age: ".age"
    male: "radio.male"
    female: "radio.female"
    submit: "[name='submit']"
# profile_page.yml 
profile_page:
    user_name: ".user"
    password: ".password"
    age: ".age"
    gender: ".gender"
```
Test steps looks like this
```ruby
# set textbox, radiobox, checkbox in one shot  
sign_up.set_fields {:user_name=> "hi",:password=>"bla",:male=>true,:age=>10}
sign_up.submit.click
# assert multiple fields
profile_page.should_match_fields {:user_name=> "hi",:male=>true,:age=>10}
# check for state of elements
sign_up.should_have_enabled ['user_name','password','male','age']
sign_up.should_have_disabled ['user_name']
```
or like this 
```ruby
on sign_up do
  user_name.set "hi"
  password.set "bla"
  submit.click
end
```

We will be able element whose locators are dynamic
```yaml
products_page: ".products"
  product: ".product[name='%s']"
    details_row: ".row:nth-of-type(%s)"
      cost: ".cost"
```
```ruby
products_page.product("candy").details_row(1).cost.should have_text "Rs.10"
products_page.product("tyres").details_row(2).cost.should have_text "Rs.20"
```

## Usage
In your project Gemfile add 
```ruby
gem 'pageify'
```
###Cucumber

```ruby
# features/support/env.rb
 require 'pageify'
 require 'pageify/capybara'
 require "capybara"
 require 'capybara/rspec'
 require 'capybara/dsl'
 require 'capybara/session'
 require 'selenium-webdriver'

 #define your capybara driver ... and 

 pageify("features/pages")
 set_session(page)
```
 Place all the page defenitions under "features/pages"

## Splitting long page definitions
Sometimes, your page definition may get quite long. In other cases, you may also have the exact same HTML component (say a product listing) that can be repeated in multiple places (e.g. list, search, etc). In these cases, you can use sections to split your page into multiple files that can be reused.

The syntax for this is as follows:

```yaml
# sections/_product.yml
product: '.product'
  name: '.name'
  price: '.price'

# product_list.yml
product_list: '.product_list'
  :section/product

# search_results.yml
search_results: '.search_results'
  :section/product

```
## How tests gets faster with Pageify

Unlike other similar tools, irrespective of the depth of the hierarchy, only a single find is fired to the browser, which is considered to be the costliest call in any test execution. 
