say_wizard 'Running Guard'

case config['guard']
  when 'no'
    recipes.delete('guard')
    say_wizard "Guard recipe skipped."
  when 'standard'
    # do nothing
  when 'LiveReload'
    recipes << 'guard-LiveReload'
  else
    recipes.delete('guard')
    say_wizard "Guard recipe skipped."
end


if recipes.include? 'guard'
  gem 'guard', '>= 0.6.2', :group => :development

  def guards
    @guards ||= []
  end

  def guard(name, version = nil)
    args = []
    if version
      args << version
    end
    args << { :group => :development }
    gem "guard-#{name}", *args
    guards << name
  end

  guard 'bundler', '>= 0.1.3'

  unless recipes.include? 'pow'
    guard 'rails', '>= 0.1.0'
  end

  if recipes.include? 'guard-LiveReload'
    guard 'livereload', '>= 0.4.2'
  end

  if recipes.include? 'spork'
    guard 'spork', '>= 0.5.2'
  end

  if recipes.include? 'rspec'
    guard 'rspec', '>= 0.7.0'
  end

  if recipes.include? 'cucumber'
    guard 'cucumber', '>= 0.7.5'
  end

  after_bundler do
    run 'guard init'
    guards.each do |name|
      run "guard init #{name}"
    end
  end

else
  recipes.delete 'guard'
end

__END__

name: guard
description: "Automate your workflow with Guard"
author: ashley_woodard

run_after: [rspec, cucumber]
category: other
tags: [dev]

config:
  - guard:
      type: multiple_choice
      prompt: Would you like to use Guard to automate your workflow?
      choices: [["No", no], ["Guard default configuration", standard], ["Guard with LiveReload", LiveReload]]
