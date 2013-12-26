# Serveit


## Thoughts

What if you could build this out of a whole bunch of the same middleware that was just configurable to find certain files based on the request path and if one matches do something this it and either return or keep going up the chain.

So the controllers module can just look for a controller based on the request path and add things to the request env for later middleware that can find the haml template or whatever and render that passing given data into the view renderer

If the controller water a different template to be rendered it could pass that instruction into the request env and whoever supports it can grab it.

the authentication module would be programmable to require authentication before whatever paths, configurable with ruby code. when auth is passed, it puts the users in the request env and throws it up the chain



also each middleware i make can share objects like a Rack::Requset and Rack::Response by ||=ing an object in env['serveit']

```ruby
  use Rack::CommonLogger, STDERR
  use Rack::ShowExceptions
  use Rack::Lint
  use Rack::Accept
  use Serveit::Logger
  # use Serveit::Router
  use Serveit::Controllers
  use Serveit::HamlTemplates
  use Serveit::ErbTemplates
  use Serveit::SassTemplates
  use Serveit::Sprockets
  use Serveit::Static
```

## Installation

Add this line to your application's Gemfile:

    gem 'serveit'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install serveit

## Usage

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
