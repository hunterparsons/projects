import requests
import key
KEY = key.KEY
URL = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline"
def get_weather(location):
	apiURL = f"{URL}/{location}&include=alerts,current"
	usrParams = {
		"unitGroup" : "us", # Sets units to imperial and fahrenheit
		"key" : KEY,
		"include" : "current"
	}
	response = requests.get(apiURL, params = usrParams)
	if response.status_code == 200:
		return response.json()
	else:
		raise Exception(f"Unable to fetch weather data. HTTP {response.status_code}") # throws error if not able to get weather data.

