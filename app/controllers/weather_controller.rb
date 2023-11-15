class WeatherController < ApplicationController
  before_action :set_cache_key, only: [:forecast]

  def forecast
    cached_data = Rails.cache.read(@cache_key)

    if cached_data
      @forecast = cached_data
      @from_cache = true
    else
      @forecast = fetch_forecast(params[:address])
      Rails.cache.write(@cache_key, @forecast)
      @from_cache = false
    end
  end

  private

  def set_cache_key
    @cache_key = "weather_forecast_#{params[:address]}"
  end

  def fetch_forecast(address)
    # Use the OpenWeatherMap API to fetch forecast data (replace "YOUR_API_KEY" with your actual API key)
    api_key = "YOUR_API_KEY"
    endpoint = "http://api.openweathermap.org/data/2.5/weather"
    response = HTTParty.get(endpoint, query: { q: address, appid: api_key, units: 'metric' })

    if response.code == 200
      data = response.parsed_response
      {
        temperature: data['main']['temp'],
        city: data['name'],
        country: data['sys']['country'],
        from_cache: false
      }
    else
      { error: 'Unable to fetch forecast data.' }
    end
  end
end