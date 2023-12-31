# ColumnApi

_This gem is under development and the API is unstable._

[![Gem Version](https://badge.fury.io/rb/column_api.svg)](https://badge.fury.io/rb/column_api)

Ruby bindings for [Column's API](https://column.com/docs/api).

## Installation

```ruby
gem 'column_api', '~> 0.0.2'
```

## Usage

```ruby
client = ColumnApi::Client.new(api_key: ENV["COLUMN_API_KEY"])

client.entities.retrieve(entity_id: "enti_2aELWf6D")
# => #<ColumnApi::PersonEntity documents=[], id="enti_2aELWf6D", is_root=true, type="PERSON" (...)>
```

Alternatively, you can query the endpoints directly:

```ruby
client.connection.get("entities/enti_2aELWf6D").body
# =>
# {"documents"=>[],
#  "id"=>"enti_2aELWf6D",
#  "is_root"=>true,
#  "person_details"=> {...}
# }
```

## Resources

### Entities

https://column.com/docs/api/#entity/object

```ruby
client.entities.list({})
client.entities.retrieve(entity_id: "ID")
client.entities.create_person({})
client.entities.create_business({})
client.entities.update_person(entity_id:, params: {})
client.entities.update_business(entity_id:, params: {})
client.entities.delete(entity_id: "ID")
client.entities.submit_document(entity_id: "ID", params: {})
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/matiasleidemer/column_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/matiasleidemer/column_api/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ColumnApi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/matiasleidemer/column_api/blob/main/CODE_OF_CONDUCT.md).
