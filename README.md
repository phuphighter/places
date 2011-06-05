# Google Places

Ruby wrapper for the [Google Places API](http://code.google.com/apis/maps/documentation/places/).

## Installation

Inside your Gemfile:
  gem 'places'
    
## Get Google Places API credentials

Go here and activate it: [https://code.google.com/apis/console](https://code.google.com/apis/console)
    
## Usage

### Instantiate a client

    >> @client = Places::Client.new(:api_key => 'your_api_key')
    
## Examples

#### Search for a place

    >> @search = @client.search(:lat => 32.8481659, :lng => -97.1952847, :types => "food", :name => "roots")
    >> @search.results.first.name
    => 'Roots Coffeehouse'
    
#### Get details for a place
    
    >> @detail = @client.details(:reference => "CnRpAAAAjVikwLlaJ2WN8i0cPwu3A0zcE9iCSMDihmbn_bkXYkM-7xtRcn-ZAmrQtWAAzxQPYxZmyaCeNIMQ_t_eWNDp1CmviA-iY-M63UjpUywQeR5B1dmZ2_Ne756bAjp2uYXTxobVtLKeWkVmGz2dFUMacRIQ6MbrsRQfx1fIbMf4s-s6RhoU-5Uxc26iNf80jxRypRlMJl_k6Gg")
    >> @detail.result.name
    >> 'Roots Coffeehouse'
    
#### Check-in to a place
    
    >> @checkin = @client.checkin(:reference => "CnRpAAAAjVikwLlaJ2WN8i0cPwu3A0zcE9iCSMDihmbn_bkXYkM-7xtRcn-ZAmrQtWAAzxQPYxZmyaCeNIMQ_t_eWNDp1CmviA-iY-M63UjpUywQeR5B1dmZ2_Ne756bAjp2uYXTxobVtLKeWkVmGz2dFUMacRIQ6MbrsRQfx1fIbMf4s-s6RhoU-5Uxc26iNf80jxRypRlMJl_k6Gg")

#### Add a new place

    >> @add = @client.add(:lat => -33.8669710, :lng => 151.1958750, :accuracy => 50, :name => "Google Shoes!", :types => "shoe_store")

#### Delete a place

    >> @delete = @client.delete(:reference => "CkQxAAAAgoh_Zw4jcE_9-B1b56AgriFZKVdpgc5yYXtwRAPjs-aWIxgUi6Wl-Qe-DdDP5m7PUCzy9iOqWWmdx4sU53035RIQqqNIGGPevJaTM9l1Xh9hpRoUWxhdGBS0XppFiJhZMXX_jiuDsdY")

## Copyright

Contact me if you have any suggestions and feel free to fork it!

Copyright (c) 2009 Johnny Khai Nguyen, released under the MIT license
