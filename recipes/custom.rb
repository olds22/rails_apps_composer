# Run this recipe at the end, just before git
after_bundler do
  say_wizard "Running custom cleanup & template recipe"

  # remove unnecessary files
  %w{
    README
    doc/README_FOR_APP
    public/index.html
    app/assets/images/rails.png
  }.each { |file| remove_file file }

  # use custom templated files - be sure to keep them up to date with recipes used
  # generation recipe:
  # be rails_apps_composer template ../templates/cabforward.rb -r spork rspec cucumber guard action_mailer sass_custom devise add_user static_page seed_database users_page backbone html5 simple_form custom git
  customized_files = %w{
    Gemfile
    spec/spec_helper.rb
    Guardfile
  }
  customized_files.each { |file|
    remove_file file
    get 'https://raw.github.com/olds22/rails_apps_composer/fork/custom/' + file, file
  }

  # remove commented lines and multiple blank lines from config/routes.rb
  gsub_file 'config/routes.rb', /  #.*\n/, "\n"
  gsub_file 'config/routes.rb', /\n^\s*\n/, "\n"
end

__END__

name: Custom Cleanup
description: "Remove unnecessary files and insert custom setup files."
author: olds22
based_on: RailsApps

category: other
tags: [utilities, configuration]
