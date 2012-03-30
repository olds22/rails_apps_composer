say_wizard 'Running Spork Setup'

gem 'spork-rails', '>= 3.2.0', group: :development

after_bundler do
  run 'bundle exec spork rspec --bootstrap'
  run 'bundle exec spork cucumber --bootstrap'
end

__END__

name: Spork
description: "Use the Spork drb server to run tests."
author: olds22

category: testing
