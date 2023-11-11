
task :fetch do
  ruby "backend/fetch/main.rb"
end

task :api do
  ruby "backend/api/main.rb"
end

task :api_prod do
  ENV["APP_ENV"] = "production"
  ruby "backend/api/main.rb"
end

task :frontend do
  cd "frontend"
  sh "npm run start"
end

namespace :test do
  task :fetch do
    ruby "backend/test/crawler_test.rb"
  end

  task :db do
    ruby "backend/test/db_test.rb"
  end
end

