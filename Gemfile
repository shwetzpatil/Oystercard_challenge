# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

ruby '2.5.1'

group :development, :test do
  gem 'rspec'
end

group :test do
  gem 'simplecov', require: true
  gem 'simplecov-console', require: true
end
