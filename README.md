San Francisco Weather Comparison
=================================
A little toy which helps compare the weather of neighborhoods in San Francisco.  Written as a tool to help decide where to live.
Don't believe the locals - use science!


Setup
-----
* You'll need to sign up for a free developer API account at [Wunderground.com](http://www.wunderground.com/weather/api "Wunderground").
* Paste your key in file named `wu.key`
* Neighborhoods will be loaded from `locations.yml.exxample`.  If you want to add/remove neighborhoods, create a `locations.yml` file similar to the example.  You can see a list of weather stations [here](http://www.wunderground.com/weatherstation/ListStations.asp?selectedState=CA&selectedCountry=United+States)

Run It
------

    gem install bundler
    bundle install
    rake
