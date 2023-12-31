[![Maintainability](https://api.codeclimate.com/v1/badges/43aa9279fa11d33f6fa3/maintainability)](https://codeclimate.com/github/matiasleidemer/column_api/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/43aa9279fa11d33f6fa3/test_coverage)](https://codeclimate.com/github/matiasleidemer/column_api/test_coverage)

# ColumnApi

_This gem is under development and the API is unstable._

Ruby bindings for [Column's API](https://column.com/docs/api).

## Installation

```ruby
gem 'column_api', '~> 0.0.6'
```

## Usage

```ruby
client = ColumnApi::Client.new(api_key: ENV["COLUMN_API_KEY"])

person = client.entities.retrieve(entity_id: "enti_2aELWf6D")
person.id # => enti_2Q1ctiJm1NypVqCt8UBC8e4xTfH
person.person_details.email # => oliver@column.com

bank_accounts = client.bank_accounts.list({ limit: 2 })
bank_accounts.data # => [#<ColumnApi::BankAccount>, #<ColumnApi::BankAccount>]
bank_accounts.has_more # => true
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
client.entities.retrieve(entity_id:)
client.entities.create_person({})
client.entities.create_business({})
client.entities.update_person(entity_id:, params: {})
client.entities.update_business(entity_id:, params: {})
client.entities.delete(entity_id:)
client.entities.submit_document(entity_id:, params: {})
```

### Bank Accounts

https://column.com/docs/api/#bank-account/object

```ruby
client.bank_accounts.list({})
client.bank_accounts.retrieve(bank_account_id:)
client.bank_accounts.create({})
client.bank_accounts.update(bank_account_id:, params: {})
client.bank_accounts.delete(bank_account_id:)
client.bank_accounts.history(bank_account_id:, from_date: Date, to_date: Date)
```

### Account Numbers

https://column.com/docs/api/#account-number/object

```ruby
client.account_numbers.list(bank_account_id:, params: {})
client.account_numbers.retrieve(account_number_id:)
client.account_numbers.create(bank_account_id:, params: {})
```

### ACH Transfers

https://column.com/docs/api/#ach-transfer/object

```ruby
client.ach_transfers.list({})
client.ach_transfers.retrieve(ach_transfer_id:)
client.ach_transfers.create({})
client.ach_transfers.cancel(ach_transfer_id:)
client.ach_transfers.reverse(ach_transfer_id:, reason:, description: "")
```

### ACH Returns

https://column.com/docs/api/#ach-return/object

```ruby
client.ach_returns.list(params = {})
client.ach_returns.retrieve(ach_transfer_id:)
client.ach_returns.create(ach_transfer_id:, params: {})
```

### Wire Transfers

https://column.com/docs/api/#wire-transfer/object

```ruby
client.wire_transfers.list({})
client.wire_transfers.retrieve(wire_transfer_id:)
client.wire_transfers.create({})
client.wire_transfers.reverse(wire_transfer_id:, reason:, description: "")
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
