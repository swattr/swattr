# Swattr

**Swattr is currently under development. It is not ready for production use.**

The new kid on the block. The one that promises not to take your lunch money.

Swattr is a bug and issue tracker meant to be a lightweight, simple to set up and easy to use. Additional functionality can be added with additional extensions to make your tracker as complex as you like.

## Table of contents

* [Requirements](#requirements)
* [Installation](#installation)
* [Updating](#updating)
* [Testing](#testing)
* [Bugs and feature requests](#bugs-and-feature-requests)
* [License](#license)
* [Contributing](#contributing)

## Requirements

- Rails 4.2.4+

## Installation

Add to your application's Gemfile:

```
gem "swattr", github: "swattr/swattr"
```

Run the bundle command:

```
bundle install
```

Run the install generator:

```
rails g swattr:install
```

Run the install generator with seed data:

```
rails g swattr:install --seed
```

Seed data can be created separately by running `rake db:seed`

## Updating

Subsequent updates can be done by bumping the version in your Gemfile then adding the new migrations:

```
rake swattr:install:migrations
```

Run migrations:

```
rake db:migrate
```

## Testing

```
bundle exec rspec spec
```

## Bugs and feature requests

Have a bug or a feature request? First read the [issue guidelines](https://github.com/swattr/swattr/blob/master/CONTRIBUTING.md#using-the-issue-tracker) and search for existing and closed issues. If your problem or idea is not addressed yet, [please open a new issue](https://github.com/swattr/swattr/issues/new).

## License

Code released under the [MIT license](https://github.com/swattr/swattr/blob/master/MIT-LICENSE).

## Contributing

Please read through our [contributing guidelines](https://github.com/swattr/swattr/blob/master/CONTRIBUTING.md).

1. Fork it ( https://github.com/swattr/swattr/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
