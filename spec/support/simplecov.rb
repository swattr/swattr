require "simplecov"

SimpleCov.start :rails do
  add_group "Modules", "app/modules"
  add_group "Services", "app/services"
  add_group "Uploaders", "app/uploaders"
end
