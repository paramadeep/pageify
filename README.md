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
home_page.login.user_name[].set "hi"
home_page.login.password[].set "bla"
home_page.login.submit[].click

home_page.profile_name[].should match_text "hi"
hoem_page.settings[].should be_visible
```

We will be able element whose locators are dynamic
```yaml
products_page: ".products"
  product: ".product[name='%s']"
    details_row: ".row:nth-of-type(%s)"
      cost: ".cost"
```
```ruby
products_page.product("candy").details_row(1).cost[].should have_text "Rs.10"
products_page.product("tyres").details_row(2).cost[].should have_text "Rs.20"
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
 require 'pageify'
 require 'pageify/capybara'
 include Pageify
 
 pageify("features/pages")
 ```
 Place all the page defenitions under "features/pages"

##Methods

###Get Element '[]'
```ruby
home_page.login.user_name[] #=> user_name text box
home_page.login.user_name[].set "hi" # set text box value
home_page.login.user_name[].should have_value "hi" # assert value
home_page.login.submit[].click
```


###Get Selector 'p'
At times we would need selector of the object 
```ruby
home_page.login.user_name.p #=> ".home div.login input.user"

#check element doesn't exist
page.should_not have_selector home_page.login.user_name.p

#using capybara actions
fill_in  home_page.login.user_name.p, :with=> "hi"
click_on home_page.login.submit.p
```

##Splitting Long Page Definitions
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
