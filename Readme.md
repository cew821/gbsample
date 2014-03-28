## Readme ##

This is a sample application that uses the [Green Button gem](https://github.com/cew821/greenbutton) to parse data collected from a server that responds to GET requests for Green Button usage points.

It is built using Sinatra and HighCharts, and is merely meant to provide a simple example of the Green Button parser library at work.

## Running Locally ##

You will need Ruby installed.

To run locally, clone the repository, `cd` into the repo, and run `$ bundle install`. Then, `$ ruby gbsample.rb` to start a server. Visit http://localhost:4567/greenbutton to initiate a request to the sample Green Button data endpoint (in this case https://services.greenbuttondata.org/DataCustodian/espi/1_1/resource/Batch/RetailCustomer/1/UsagePoint). Once the file has been loaded from the server, it will be parsed and displayed on the chart.

The action happens in `gbsample.rb`.

This software is Open Source. See license.txt for more details.