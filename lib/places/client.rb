module Places
  
  class Client
    include HTTParty
    base_uri "https://maps.googleapis.com/maps/api/place"
    
    attr_reader :api_key
                
    def initialize(options={})
      @api_key = options[:api_key] || GooglePlaces.api_key
    end

    def search(options={})
      radius = options.delete(:radius) || 500
      sensor = options.delete(:sensor) || false
      types  = options.delete(:types)
      name  = options.delete(:name)
      lat = options.delete(:lat)
      lng = options.delete(:lng)
      location = [lat,lng].join(',')

      options = {
        :location => location,
        :radius => radius,
        :sensor => sensor,
        :name => name
      }
      
      if types
        types = (types.is_a?(Array) ? types.join('|') : types)
        options.merge!(:types => types)
      end
        
      mashup(self.class.get("/search/json", :query => options.merge(self.default_options)))
    end
    
    def details(options={})    
      sensor = options.delete(:sensor) || false  
      reference = options.delete(:reference)      
      options = {:reference => reference, :sensor => sensor}    
      mashup(self.class.get("/details/json", :query => options.merge(self.default_options)))      
    end
    
    def checkin(options={})
      sensor = options.delete(:sensor) || false  
      reference = options.delete(:reference)
      mashup(self.class.post("/check-in/json?sensor=#{sensor}&key=#{@api_key}", :body => {:reference => reference}.to_json))
    end
    
    def add(options={})
      sensor = options.delete(:sensor) || false
      accuracy = options.delete(:accuracy)
      types  = options.delete(:types)
      name  = options.delete(:name)
      lat = options.delete(:lat)
      lng = options.delete(:lng)
      
      options = {
        :location => {:lat => lat, :lng => lng},
        :name => name,
        :accuracy => accuracy,
        :types => [types]
      }
                      
      mashup(self.class.post("/add/json?sensor=#{sensor}&key=#{@api_key}", :body => options.to_json))
    end
    
    def delete(options={})
      sensor = options.delete(:sensor) || false  
      reference = options.delete(:reference)
      mashup(self.class.post("/delete/json?sensor=#{sensor}&key=#{@api_key}", :body => {:reference => reference}.to_json))
    end
    
    protected
    
    def default_options
      { :key => @api_key }
    end
    
    def mashup(response)
      case response.code
      when 200
        if response.is_a?(Hash)
          Hashie::Mash.new(response)
        else
          if response.first.is_a?(Hash)
            response.map{|item| Hashie::Mash.new(item)}
          else
            response
          end
        end
      end
    end
    
  end
end
