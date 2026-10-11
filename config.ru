require "rubygems"
require "bundler"

Bundler.require

require_relative "app"

puma_options = {
  Host: "0.0.0.0",
  Port: 4567
}

handler = Rackup::Handler.get("puma")
handler.run(WebTaskRoller, **puma_options)
