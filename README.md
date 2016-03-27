# Imdb [![Build Status](https://travis-ci.org/egwspiti/imdb.svg?branch=master)](https://travis-ci.org/egwspiti/imdb)

Imdb is a gem that fetches and parses data from imdb.

## Installation

Add this line to your application's Gemfile:

    gem 'imdb', github: 'egwspiti/imdb'

And then execute:

    $ bundle

## Usage

One can get info for a movie by providing the movie's id to Imdb.get
like this:

    require 'imdb'
    Imdb::get(id: 'tt2415458')

'tt' can be ommited, thus one could use:

    Imdb::get(id: '2415458')

or even:

    Imdb::get(id: 2415458)

## Contributing

1. Fork it ( http://github.com/egwspiti/imdb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
