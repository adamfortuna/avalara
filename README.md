# Avalara gem

This API provides access to the [Avalara](http://www.avalara.com/) AvaTax API.

[![Build Status](https://travis-ci.org/adamfortuna/avalara.png)](https://travis-ci.org/adamfortuna/avalara)

## Setup

Add the gem to your `Gemfile`.

```
gem 'avalara'
```

Setup your Avalara credentials, either in a yml file, or as environment variables. If you want to add a yml file, it'll just need `username` and `password`:

```
username: 'testaccount'
password: 'testkey'
```

You can also specify a different endpoint for development mode:

```
https://development.avalara.net
```

Setup the gem in an initializer (if using Rails), or wherever if you're not. You can load in your username/password however you want, but here's a sample way to do this:

```
file = File.new(File.join(Rails.root, 'config', 'avalara.yml'))

if file.exist?
  begin
    AVALARA_CONFIGURATION = YAML.load_file(path)
    Avalara.configure do |config|
      config.username = AVALARA_CONFIGURATION['username'] || abort("Avalara configuration file (#{path}) is missing the username value.")
      config.password = AVALARA_CONFIGURATION['password'] || abort("Avalara configuration file (#{path}) is missing the password value.")
      config.version = AVALARA_CONFIGURATION['version'] if AVALARA_CONFIGURATION.has_key?('version')
      config.endpoint = AVALARA_CONFIGURATION['endpoint'] if AVALARA_CONFIGURATION.has_key?('endpoint')
    end'
  end
else
  abort "Avalara configuration not found."
end
```

## Usage

After that you should be able to use a few endpoints to Avalaras tax service. If you need a new endpoint, feel free to fork this gem, add support for it, add specs and do a pull request back.

### Geographical Tax

```
result = Avalara.geographical_tax('47.627935', '-122.51702', 100)

# Access the details of the result, which is a Avalara::Response::Tax object
result.rate
result.tax
result.tax_details
```

### Get Tax

```
line = Avalara::Request::Line.new({  
  line_no: "1",
  destination_code: "1",
  origin_code: "1",
  qty: "1",
  amount: 10
})

address = Avalara::Request::Address.new({
  address_code: 1,
  line_1: "435 Ericksen Avenue Northeast",
  line_2: "#250",
  postal_code: "98110"
})

invoice = Avalara::Request::Invoice.new({
  doc_date: Time.now,
  company_code: 1,
  lines: [line],
  addresses: [address]
})

# You'll get back a Response::Invoice object
result = Avalara.get_tax(invoice) 

result.result_code
result.total_amount
result.total_tax
result.total_tax_calculated
```


## Contributing

If you want to contribute, please fork this repo and make a pull request back. If you add some specs and everything still passes, we can get your contribution in! Thanks to everyone who has contributed:

* [Adam Fortuna](http://github.com/adamfortuna)
* [James Cox](http://github.com/adamfortuna)
* [Dan Sosedoff](http://github.com/sosedoff)
