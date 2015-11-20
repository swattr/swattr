# ruby encoding: utf-8

require "highline/import"

unless Swattr::User.first
  email = ask("Email address:  ") { |q| q.default = "me@example.com" }
  password = ask("Password:  ") { |q| q.echo = "*" }

  Swattr::User.create(email: email,
                      password: password,
                      password_confirmation: password,
                      confirmed_at: Time.current)
end

# Priorities
%w(High Low Normal Urgent).each_with_index do |name, index|
  Swattr::Priority.find_or_create_by(name: name) do |item|
    item.position = index
  end
end

# Resolutions
["Can Not Reproduce", "Resolved"].each_with_index do |name, index|
  Swattr::Resolution.find_or_create_by(name: name) do |item|
    item.position = index
  end
end

# Statuses
["In Progress", "Blocked"].each_with_index do |name, index|
  Swattr::Status.find_or_create_by(name: name) do |item|
    item.position = index
  end
end

# Tags
["Bug", "Feature", "Invalid", "Question", "Won't Fix"]
  .each_with_index do |name, index|
  Swattr::Tag.find_or_create_by(name: name, tag: name.parameterize) do |item|
    item.position = index
  end
end
