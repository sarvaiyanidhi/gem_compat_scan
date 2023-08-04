# GemCompatScan

GemCompatScan is a Ruby gem that helps you scan your project's Gemfile, compare the currently used gem versions with the latest available versions, and generate a PDF report with the results.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gem_compat_scan'
```

## Usage

To use GemCompatScan, simply run the following command in your project's root directory:

```ruby
bin/gem_compat_scan
```

This command will scan your project's Gemfile, compare the currently used gem versions with the latest available versions, and generate a PDF report named gem_updates_report.pdf in the same directory.

## Example

Assuming you have the following Gemfile:

```ruby
source 'https://rubygems.org'

gem 'rails', '6.0.3'
gem 'devise', '~> 4.7'
gem 'sidekiq', '6.2.1'
```

Running gem_compat_scan will generate a PDF report that looks like this:

```yaml
Gem Updates Report

Gem: rails
Current Version: 6.0.3
Latest Version: 7.0.0

Gem: devise
Current Version: 4.7.0
Latest Version: 5.0.0

Gem: sidekiq
Current Version: 6.2.1
Latest Version: 6.3.0
```

## Contributing
- Fork the repository.
- Create a feature branch (git checkout -b feature/my-feature).
- Commit your changes (git commit -am 'Add some feature').
- Push to the branch (git push origin feature/my-feature).
- Create a new Pull Request.

## License
The gem is available as open source under the terms of the MIT License.
