require 'spec_helper'

describe Places::Client do
  
  context 'searching for a place' do
    use_vcr_cassette 'search'
  
    it 'should not initialize without an api_key' do
      lambda { Places::Client.new }.should raise_error
    end

    it 'should initialize with an api_key' do
      @client = Places::Client.new(:api_key => "foobar")
      @client.api_key.should == "foobar"
    end

    it 'should request a place search' do    
      @client = Places::Client.new(:api_key => "foobar")
      @search = @client.search(:lat => 32.8481659, :lng => -97.1952847, :types => "food", :name => "roots")
      @search.results.size.should == 1
      @search.results.first.name.should == 'Roots Coffeehouse'
    end
  end
  
  context 'details for a place' do
    use_vcr_cassette 'details'
    
    it "should fetch details of a specific places" do
      @client = Places::Client.new(:api_key => "foobar")
      @detail = @client.details(:reference => "CnRpAAAAjVikwLlaJ2WN8i0cPwu3A0zcE9iCSMDihmbn_bkXYkM-7xtRcn-ZAmrQtWAAzxQPYxZmyaCeNIMQ_t_eWNDp1CmviA-iY-M63UjpUywQeR5B1dmZ2_Ne756bAjp2uYXTxobVtLKeWkVmGz2dFUMacRIQ6MbrsRQfx1fIbMf4s-s6RhoU-5Uxc26iNf80jxRypRlMJl_k6Gg")
      @detail.result.formatted_address.should == "9101 Blvd 26, Suite 101, North Richland Hills, TX 76180, United States"
      @detail.result.name.should == 'Roots Coffeehouse'
      @detail.result.id.should == "8e4570eb70ddeea123e33d0c6b584ffe3a967d4e"
    end
  end
  
  context 'check-in to a place' do
    use_vcr_cassette 'checkin'
    
    it "should check-in to a specific place" do
      @client = Places::Client.new(:api_key => "foobar")
      @checkin = @client.checkin(:reference => "CnRpAAAAjVikwLlaJ2WN8i0cPwu3A0zcE9iCSMDihmbn_bkXYkM-7xtRcn-ZAmrQtWAAzxQPYxZmyaCeNIMQ_t_eWNDp1CmviA-iY-M63UjpUywQeR5B1dmZ2_Ne756bAjp2uYXTxobVtLKeWkVmGz2dFUMacRIQ6MbrsRQfx1fIbMf4s-s6RhoU-5Uxc26iNf80jxRypRlMJl_k6Gg")
      @checkin.status.should == "OK"
    end
  end
  
  context 'adding a place' do
    use_vcr_cassette 'add'
    
    it "should add a new place" do
      @client = Places::Client.new(:api_key => "foobar")
      @add = @client.add(:lat => -33.8669710, :lng => 151.1958750, :accuracy => 50, :name => "Google Shoes!", :types => "shoe_store")
      @add.id.should == "a306f93119e8d12eabadb79bd82f0d3e547d0ad2"
      @add.status.should == "OK"
    end
  end
  
  context 'deleting a place' do
    use_vcr_cassette 'delete'
    
    it "should delete a specific place" do
      @client = Places::Client.new(:api_key => "foobar")
      @delete = @client.delete(:reference => "CkQxAAAAgoh_Zw4jcE_9-B1b56AgriFZKVdpgc5yYXtwRAPjs-aWIxgUi6Wl-Qe-DdDP5m7PUCzy9iOqWWmdx4sU53035RIQqqNIGGPevJaTM9l1Xh9hpRoUWxhdGBS0XppFiJhZMXX_jiuDsdY")
      @delete.status.should == "OK"
    end
  end
end