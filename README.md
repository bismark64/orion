# Orion

Orion is an tiny gem to search and delete files in the filesystem, using the Find and File Ruby modules.

## Installation

Add this line to your application's Gemfile:

    gem 'orion'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install orion

## Usage

For the time being Orion allows you to run just two methods:

1. Searching files:

    Orion.search "path/where/you/want/to/search/in", "query"

The result of that request has the following form:

    {success: boolean, count: number_of_files_found, files: array_with_string_paths_representing_found_files}

If Orion can't find the requested files the above hash will look like:

    {success: false, count: nil, files: nil}

2. Deleting files

    Orion.delete "path/where/you/want/to/search/in", "query"

The delete method behind the scenes uses the search method to find the files, and if so it deletes all of them.

It also returns the same hash than search method:

    {success: boolean, count: number_of_files_deleted, files: array_with_string_paths_representing_deleted_files}
    
If Orion can't find the requested files the above hash will look like:

    {success: false, count: nil, files: nil}    

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
