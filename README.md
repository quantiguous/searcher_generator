# SearcherGenerator

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'searcher_generator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install searcher_generator

## Usage

    rails generate search <ModelName> atrribute:"attribute humanize name" 

    This will create:
        1-  searcher class '<ModelSearcher>'
        2-  advanced_search partial for '<ModelSearcher>'
        3- insert search_params method in '<ModelControllers>'
        4- en.yml file
        
    rules you have to follow for this generator- 
      1-  add these word to your attribute for giving different functionality -
        (i) bet1 - it will create "from attribute" and "to attribute"
        (ii) bet$ - it will create "from attribute" and "to attribute" as datetime type
        (iii) e$  -  it will create enum type attribute
        (iv) approval_status@ - it will create approval_status attribute
        (v) page@ - it will create page attribute
     
     Things to do after running this command 
        1- changes in routes file 
        2- changes in controller method 'index'
        3- define enum attributes  for searcher


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/quantiguous/searcher_generator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

