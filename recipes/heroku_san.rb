gem 'heroku_san', '>= 2.1.3', group: :development

after_bundler do
  inject_into_file 'config/application.rb', after: "Rails::Application\n" do <<-RUBY
    config.assets.initialize_on_precompile = false # for Heroku
RUBY

  run 'bundle exec rake heroku:create_config'
end

__END__

name: Heroku San
description: 'generates useful rake tasks for heroku'
author: olds22

category: deploy
