require 'pry'
require 'httparty'
require 'json'

def req(
      m = "get",
      host: Local,
      path: "/",
      auth: DefaultAuth,
      body: {},
      query: {}
    )
  HTTParty.method(m).call host + path,
                          headers: { "Authorization" => auth },
                          body: body,
                          query: query
end

DefaultAuth = "a@a.com"
Heroku      = "https://livelocalrails.herokuapp.com"
Local       = "http://localhost:3000"
# Default request is # req :get, host: Local, path: "/", auth: DefaultAuth, body: {}, query: {}
binding.pry
