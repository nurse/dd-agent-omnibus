source 'https://rubygems.org'

# we default if env variable aren't set or set to an empty string
gem 'omnibus', git: 'git://github.com/datadog/omnibus-ruby.git', branch: (if ENV['OMNIBUS_RUBY_BRANCH'].to_s.empty? then 'datadog-5.5.0' else ENV['OMNIBUS_RUBY_BRANCH'] end)
gem 'omnibus-software', git: 'git://github.com/nurse/omnibus-software.git', branch: (if ENV['OMNIBUS_SOFTWARE_BRANCH'].to_s.empty? then 'master' else ENV['OMNIBUS_SOFTWARE_BRANCH'] end)

gem 'httparty'
gem 'win32-process'
gem 'ohai'
gem 'pedump', '~> 0.5.0'
gem 'rake', '~> 11.0'

# We need an older version of mixlib-cli on our version of ruby
gem 'mixlib-cli', '~> 1.7.0'
gem 'public_suffix', '~>3.0.3'

# toml-reb 2.0.0 doesn't work with Ruby 2.2
gem 'toml-rb', '1.1.2'

# license_scout 1.1 doesn't work with Ruby 2.2
gem 'license_scout', '~> 1.0'
