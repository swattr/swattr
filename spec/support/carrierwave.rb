RSpec.configure do |config|
  config.after(:all) do
    FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads"]) if Rails.env.test?
  end
end
