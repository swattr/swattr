# ruby encoding: utf-8

require "highline/import"

user = Swattr::User.first

unless user
  email = ask("Email address:  ") { |q| q.default = "me@example.com" }
  password = ask("Password:  ") { |q| q.echo = "*" }

  user = Swattr::User.create(email: email,
                             password: password,
                             password_confirmation: password,
                             confirmed_at: Time.current)
end
