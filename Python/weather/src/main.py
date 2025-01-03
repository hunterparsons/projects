import get_weather as gw
import customtkinter as ctk
from app import WeatherApp

ctk.set_appearance_mode("system")
ctk.set_default_color_theme("dark-blue")

# Loop for app
root = ctk.CTk()
app = WeatherApp(root)
root.mainloop()