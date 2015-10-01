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

# Priorities
["High", "Low", "Normal", "Urgent"].each_with_index do |name, index|
  Swattr::Priority.where(name: name).first_or_create! do |item|
    item.position = index
  end
end

# Resolutions
["Can Not Reproduce", "Resolved"].each_with_index do |name, index|
  Swattr::Resolution.where(name: name).first_or_create! do |item|
    item.position = index
  end
end

# Statuses
["In Progress", "Blocked"].each_with_index do |name, index|
  Swattr::Status.where(name: name).first_or_create! do |item|
    item.position = index
  end
end

# Tags
["Bug", "Feature", "Invalid", "Question", "Won't Fix"].each_with_index do |name, index|
  Swattr::Tag.where(name: name).first_or_create! do |item|
    item.position = index
  end
end
