source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'builder', '~> 3.0'
gem 'middleman', '~> 4.2'
gem 'middleman-autoprefixer', '~> 2.7'
gem 'middleman-blog', '~> 4.0'
gem 'middleman-imageoptim', github: 'plasticine/middleman-imageoptim', branch: 'master'
gem 'middleman-livereload', '~> 3.4.3'
gem 'redcarpet'
gem 'slim'
