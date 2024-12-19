import requests
KEY = "688LW3HN4DKE8F9RGMMFUS6NP"
URL = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline"
def get_weather(location):
	apiURL = f"{URL}/{location}"
	usrParams = {
		"unitGroup" : "us",
		"key" : KEY,
		"include" : "current"
	}
	response = requests.get(apiURL, params = usrParams)
	if response.status_code == 200:
		return response.json()
	else:
		raise(f"Unable to fetch weather data. HTTP {response.status_code}")

