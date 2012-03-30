
if config['sass_custom']
  after_bundler do
    inject_into_file 'config/application.rb', after: "config.assets.version = '1.0'\n" do <<-RUBY
    if Rails.configuration.respond_to?(:sass)
      Rails.configuration.sass.tap do |config|
        config.preferred_syntax = :sass
      end
    end
RUBY

  end
end

__END__

name: sass_custom
description: "Use SASS for stylesheets!"
author: olds22

exclusive: css_replacement
category: assets
tags: [css]

config:
  - sass_custom:
      type: boolean
      prompt: Would you like to use SASS syntax instead of SCSS?
