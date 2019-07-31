require 'httparty'

class CityWeather

	include HTTParty
	
	# default_options.update(verify: false) # Turn off SSL
    base_uri "https://api.openweathermap.org/data/2.5/weather"
    default_params appid: 'aa614c3581ae933010350ca3ee861c4e'
    format :json
    
    def CityWeather.for(city_name)
        get('', query: { q: city_name })
    end

end




