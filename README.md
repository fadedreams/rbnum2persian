### rbnum2persian

A Ruby gem for converting numbers to Persian text, handling both cardinal and ordinal numbers.

### Installation

Add this line to your application's Gemfile:

```ruby
gem 'rbnum2persian'
```

And then execute:

```ruby
$ bundle install
```

Or install it yourself as:
```ruby
$ gem install rbnum2persian
```
#### Usage
##### Basic Conversion
To convert a number to its Persian text equivalent:

```ruby
require 'rbnum2persian'
puts Rbnum2persian.num2persian(5678)  # Output: پنج هزار و ششصد و هفتاد و هشت
```
##### Handling Persian Digits
If your input includes Persian or Arabic digits:

```ruby
puts Rbnum2persian.num2persian('٥٦٧٨')  # Output: پنج هزار و ششصد و هفتاد و هشت
```
#### Ordinal numbers
To convert to ordinal form:
```ruby
puts Rbnum2persian.num2persian(5678, 0, true)  # Output: پنج هزار و ششصد و هفتاد و هشتم
```

