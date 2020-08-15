# Simple Rails user Authenticate API

# Requirements

Ruby 2.7.0
Rails 6.0.3

# How to set up locally

```
$ git clone https://github.com/matthiashaefeli/auth_api.git
$ cd auth_api
$ bundle install
$ rails db:create
$ rails db:migrate
```

# Running server

```
$ rails s
```

# Run test suit

```
$ rspec
```

# Deploy to Heroku

```
$ heroku login
$ heroku create
$ git config --list | grep heroku  # verify remote
$ git push heroku master
$ heroku ps:scale web=1  # ensure one dyno is running
$ heroku ps  # check dynos
```

# Create a User

## Ruby

```
require 'net/http'
require 'json'

uri = URI('http://my_path/signup')

response = Net::HTTP.start(uri.host, uri.port) do |http|
   req = Net::HTTP::Post.new(uri)
   req['Content-Type'] = 'application/json'
   req.body = { "user": {
                  "email": "test@test.com",
                  "password": "1234"
                }
              }.to_json
   http.request(req)
end
```

## Postman

POST: http://my_path/signup

Headers: KEY: Content-Type VALUE: application/json

Body: raw
```
{
  "user": {
    "email": "test@test.com",
    "password": "1234"
  }
}
```

# Sign in User

## Ruby

```
require 'net/http'
require 'json'

uri = URI('http://my_path/signin')

response = Net::HTTP.start(uri.host, uri.port) do |http|
   req = Net::HTTP::Post.new(uri)
   req['Content-Type'] = 'application/json'
   req.body = { "user": {
                  "email": "test@test.com",
                  "password": "1234"
                }
              }.to_json
   http.request(req)
end

token = JSON.parse(response.body)['auth_token']
```

## Postman

POST: http://my_path/signin

Headers: KEY: Content-Type VALUE: application/json

Body: raw
```
{
  "user": {
    "email": "test@test.com",
    "password": "1234"
  }
}
```
