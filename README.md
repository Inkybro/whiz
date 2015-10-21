# Whiz

Whiz is a tool I am working on for personal use at this time.

Whiz is a boilerplate generation tool. It gives you a simple binary to manage your templates, and to generate those templates into code.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'whiz'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install whiz

## Usage

Once installed, whiz can be used via the included `whiz` binary. Try running

```
whiz
```

#### `whiz --help`
You should see the help contents.

In Whiz, your templates are called `pages`. Pages are organized into `tomes`. Tomes are essentially just "groups", or more literally, folders.

#### `whiz tome`
To start out, let's list what tomes we have.

```
whiz tome list
```

At the current time, this will initially return that there are no tomes. Since there are no tomes, we can't really do much with Whiz. 

Make a tome (or 2, 3, 4):

```
whiz tome use my_tome
```

Note that the `whiz tome use` command acts both as a way of switching between and creating tomes.

You can verify your tome is being used by running

```
whiz tome current
```

If you ever need to delete a tome (including its pages!),

```
whiz tome remove my_tome
```

Now that you have a tome setup, we can continue.

#### `whiz list`

Lists all pages in the current tome.

#### `whiz edit`

You can create and edit pages like,

```
whiz edit my_page
```

This opens the file for editing in `nano`, at this time.

#### `whiz destroy`

You can destroy pages like,

```
whiz destroy my_page
```

#### `whiz generate`

You can generate code using the generate command.

The first argument is the page name, and the second is the path to the file you'd like to write.

Any additional arguments are passed as space-separated key-value pairs in the format `key=value`. The additional arguments passed here are used as locals in the pages. This is useful for cases where you want to plug in your own values on generation.

Here's an example,

```
whiz generate my_page ./my_page.rb my_var=my_value my_other_var=123
```

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/whiz.

