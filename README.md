![travis status](https://travis-ci.org/riggy/zoomba.svg?branch=master)
[![Code Climate](https://codeclimate.com/github/riggy/zoomba/badges/gpa.svg)](https://codeclimate.com/github/riggy/zoomba)
[![Test Coverage](https://codeclimate.com/github/riggy/zoomba/badges/coverage.svg)](https://codeclimate.com/github/riggy/zoomba/coverage)
[![Issue Count](https://codeclimate.com/github/riggy/zoomba/badges/issue_count.svg)](https://codeclimate.com/github/riggy/zoomba)

# Zoomba

Zoomba is implementation of Zoom.us API, loosely inspired by [zoomus gem](https://github.com/mllocs/zoomus).

It aims to provide object mapping for Zoom.us data and convenient methods to interact with those data and the API.

## Supported API endpoints

So far gem supports the following Zoom.us endpoints:

* /user/create
* /user/autocreate
* /user/custcreate
* /user/ssocreate
* /user/list
* /user/pending
* /user/get
* /user/getbyemail
* /user/checkemail
* /user/checkzpk
* /user/delete
* /user/deactivate
* /user/update
* /user/updatepassword
* /user/revoketoken
* /user/permanentdelete


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zoomba'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zoomba

## Usage

First configure Zoomba with this code:

    Zoomba.configure do |c|
      c.api_key = API_KEY
      c.api_secret = API_SECRET
    end
    
Then, for example, to fetch all users:

    Zoomba::User.list
    
It will return a collection of `Zoomba::User` instances.

More usage tips to follow...

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/riggy/zoomba. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

