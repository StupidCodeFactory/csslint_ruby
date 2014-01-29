# CsslintRuby

API to lint your css source code from ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'csslint_ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csslint_ruby

## Usage

```ruby
    source = "body { background: red;}"
    CsslintRuby.run(source) # => <CsslintRuby::Result:0x007ff7629b4018 @errors=[], @warnings=[]>
```

You can also provide pass an option hash to provide CSSLint with a custom set of rules. You can check the full list [here](https://github.com/stubbornella/csslint/wiki/Rules)

```ruby
   options = {errors: ['known-properties', 'display-property-grouping'], warnings: ['box-model'], ignore: ['import']}
   CsslintRuby.run(source, options) # => <CsslintRuby::Result:0x007ff76287b160 @errors=[{"type"=>"error", "line"=>2, "col"=>8, "message"=>"Expected (inline | block | list-item | inline-block | table | inline-table | table-row-group | table-header-group | table-footer-group | table-row | table-column-group | table-column | table-cell | table-caption | box | inline-box | grid | inline-grid | none | inherit | -moz-box | -moz-inline-block | -moz-inline-box | -moz-inline-grid | -moz-inline-stack | -moz-inline-table | -moz-grid | -moz-grid-group | -moz-grid-line | -moz-groupbox | -moz-deck | -moz-popup | -moz-stack | -moz-marker | -webkit-box | -webkit-inline-box) but found 'asdas'.", "evidence"=>"body { display: asdas;}", "rule"=>{"id"=>"known-properties", "name"=>"Require use of known properties", "desc"=>"Properties should be known (listed in CSS3 specification) or be a vendor-prefixed property.", "browsers"=>"All"}}], @warnings=[]>
```

Alternatively ``` CsslintRuby.run``` can accept anything the acts like in ```IO``` object.
```ruby
    source = File.open('/path/to/my/css/file.css')
    CsslintRuby.run(source) # => <CsslintRuby::Result:0x007ff7629b4018 @errors=[], @warnings=[]>
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/csslint_ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
