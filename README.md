#Pageify

[![Code Climate](https://codeclimate.com/github/paramadeep/pageify.png)](https://codeclimate.com/github/paramadeep/pageify)    [![Dependency Status](https://gemnasium.com/paramadeep/pageify.svg)](https://gemnasium.com/paramadeep/pageify)  [![Build Status](https://travis-ci.org/paramadeep/pageify.svg?branch=master)](https://travis-ci.org/paramadeep/pageify)

Simplest way to define page objects. Bonus, tremendously fast tests.

##Example

Page definition looks like this
```yaml
sign_up: ".home"
    user_name: ".user"
    password: ".password"
    age: ".age"
    male: "radio.male"
    female: "radio.female"
    submit: "[name='submit']"
profile_page:
    user_name: ".user"
    password: ".password"
    age: ".age"
    gender: ".gender"
```
Test steps looks like this
```ruby
# set textbox, radiobox, checkbox in one shot  
sign_up.should_match_fields {:user_name=> "hi",:password=>'bla',:male=>true,:age=>10}
sign_up.submit.click
# assert multiple fields
profile_page.should_match_fields {:user_name=> "hi",:password=>'bla',:male=>true,:age=>10}
```

We will be able element whose locators are dynamic
```yaml
products_page: ".products"
  product: ".product[name='%s']"
    details_row: ".row:nth-of-type(%s)"
      cost: ".cost"
```
```ruby
products_page.product("candy").details_row(1).cost.f.should have_text "Rs.10"
products_page.product("tyres").details_row(2).cost.f.should have_text "Rs.20"
```

    
## Key benefits

- [Tests runs tremendously fast.] (https://github.com/paramadeep/pageify#how-tests-gets-faster-with-pageify)
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

###Get Element 'f' or 'find'
```ruby
home_page.login.user_name.f #=> user_name text box
home_page.login.user_name.f.set "hi" # set text box value
home_page.login.user_name.find.should have_value "hi" # assert value
home_page.login.submit.find.click
```

###Get Element Collection 'find_all'
```ruby
home_page.product.find_all #=> all products in page
home_page.product.find_all[0] #=> first product in page
```

###Get Selector 'selector'
At times we would need selector of the object 
```ruby
home_page.login.user_name.selector #=> ".home div.login input.user"

#check element doesn't exist
page.should_not have_selector home_page.login.user_name.selector

#using capybara actions
fill_in  home_page.login.user_name.p, :with=> "hi"
click_on home_page.login.submit.selector
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

## Experimental Feature

Making the test more readable is a constant persuite. Currently working on removing use of "find" or "f" in every step

```
#currently
home_page.login.user_name.find.set "used"
home_page.login.user_name.find.click "used"

#with experimaental work under progress the above will look like
home_page.login.user_name.set "used"
home_page.login.user_name.click "used"
```
You can try this in your test suite by 
```
#instead of the adding the below line 
require 'pageify/capybara'

# use this
require 'pageify/capybara_experimental'
```
**Note:** There will be a considrable drop in performance, with the use of this experimental feature. Once this performance drop is fixed, this could used in main stream.

## How tests gets faster with Pageify

Finding a street in a country, would be much faster when given state -> city -> area -> street, against searching just the street name.

Since we used entire hirerchy of the selector to locate an element, against specific selector, the identification of element gets really faster.  
For example,
```
page.find(".user_name")
page.find(".home_page .login .user_name")
# The later would be much faster, scope for search is reduced to particular container at every level.
```
The effect gets magnified when the same is done on each and every step of, hundreds and thousand steps, tests. 
