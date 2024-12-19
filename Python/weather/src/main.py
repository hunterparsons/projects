import get_weather as gw
import customtkinter as ctk

location = input()
myWeather = gw.get_weather(location)
print(f"Weather in {location}")
print(f"Temperature: {myWeather["currentConditions"]["temp"]}")
print(f"Humidity: {myWeather["currentConditions"]["humidity"]}")