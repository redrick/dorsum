# Dorsum

This gem is not trying to provide you with any complex solution for backing up your dokku container, it only dumps DB and downloads to given folder.
Over time I came to realisation that I do need this kind of backup, so I use it as task that runs in cron on my raspberry and takes care of dumping
all my dokku postgres DBs and downloading to one folder once a day so I have history of all my DB states at given time that day :)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dorsum'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dorsum

## Usage

Simply install gem as mentioned before.
It provides you with binary `dorsum_backup` which you can put to cron.

For the binary to go through DBs you want it to you first of all need to check
if the user on the machine which will be doing backups is in `authorized_keys`
of given servers it will be backing up... So add that first...

Then just place config like the example one here `dorsum.yml.example` on
machine that is doing backups inside your `/etc/` folder with rigth settings:

```yaml
databases:
  DB_NAME1: # name of the DB will be user as subfolder  in your backup folder
    host: '127.0.0.1' # IP of server with dokku postgres container
    user: 'postgres' # user used to backup (not recommended to user root...digital ocean users! :) )
    container_name: 'postgres-db' # name of dokku postgres container you created
    destination: '/backups/' # destination where to backup on machine from which backups are done...
  DB_NAME2: # you can put many DBs in here like this :)
    host: '127.0.0.1'
    user: 'postgres'
    container_name: 'postgres-db'
    destination: '/backups/'
    subdirectories: '/name/date'   subdirectories: '/name/date'
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## TODO

* set size of backups and delete oldest to fit given disk space
* hard to write specs

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dorsum. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

