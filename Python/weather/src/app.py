import customtkinter as ctk
import get_weather as gw
class WeatherApp:
    # Pre : None
    # Post : Creates basic info for the app, creates the root and sets title, and minimum window size calls function to create the rest of the app
    # Purpose : Basic initializer for app
    def __init__(self, root):
        self.root = root
        self.root.title("Weather")
        self.root.minsize(600,475)
        self.root.columnconfigure(0, weight=1)
        self.root.rowconfigure(1, weight=1)
        self.create_sub_rows()
    # Pre : None
    # Post : Clears current screen and creates basic layout of default screen, then calls functions to create the layout of each tab within the frame
    # Purpose : To create the beginning screen and call functions to create smaller parts of it
    def create_sub_rows(self):
        self.clear()
        # Upper text
        self.text = ctk.CTkLabel(master=self.root, text="Location Info", justify="center", anchor="center", font=("Roboto", 40))
        self.text.grid(row=0, column=0, pady=30, columnspan=2, sticky="ew")
        # Country
        self.area = ctk.CTkTabview(master=self.root, width=500)
        self.area.grid(row=1, column=0, columnspan=2, sticky="nsew", padx=20, pady=20)
        self.area.add("US")
        self.area.add("International")
        self.area.tab("US").columnconfigure(0, weight=1)
        self.area.tab("International").columnconfigure(0, weight=1)
        self.create_us()
        self.create_international()
    # Pre : None
    # Post : Adds labels and entry boxes for the US tab
    # Purpose : To add information for US tab
    def create_us(self):
        # City
        self.cityText = ctk.CTkLabel(master=self.area.tab("US"), text="City", justify="center")
        self.cityText.grid(row=0, column=0, pady=(5,0))
        self.city = ctk.CTkEntry(master=self.area.tab("US"), placeholder_text="Please enter your city", width=300, justify="center")
        self.city.grid(row=1, column=0, pady=10)
        # State
        self.stateText = ctk.CTkLabel(master=self.area.tab("US"), text="State", justify="center")
        self.stateText.grid(row=2, column=0, pady=(5,0))
        self.state = ctk.CTkEntry(master=self.area.tab("US"), placeholder_text="Please enter your state", width=300, justify="center")
        self.state.grid(row=3, column=0, pady=10)
        # Zip
        self.zipText = ctk.CTkLabel(master=self.area.tab("US"), text="ZIP", justify="center")
        self.zipText.grid(row=4, column=0, pady=(5,0))
        self.zip = ctk.CTkEntry(master=self.area.tab("US"), placeholder_text="Please enter your ZIP (optional)", width=300, justify="center")
        self.zip.grid(row=5, column=0, pady=10)
        # Button
        goButton = ctk.CTkButton(master=self.area.tab("US"), text="Go", width=50, hover=True, command=self.update_gui_us)
        goButton.grid(row=6, column=0, pady=10)
        self.city.bind("<Return>", self.update_gui_us)
        self.state.bind("<Return>", self.update_gui_us)
        self.zip.bind("<Return>", self.update_gui_us)
    # Pre : None
    # Post : Adds labels and entry boxes for the international tab
    # Purpose : To add information for international tab
    def create_international(self):
        # City
        self.cityIntText = ctk.CTkLabel(master=self.area.tab("International"), text="City", justify="center")
        self.cityIntText.grid(row=0, column=0, pady=(5,0))
        self.cityInt = ctk.CTkEntry(master=self.area.tab("International"), placeholder_text="Please enter your city", width=300, justify="center")
        self.cityInt.grid(row=1, column=0, pady=10)
        # Country
        self.countryText = ctk.CTkLabel(master=self.area.tab("International"), text="Country", justify="center")
        self.countryText.grid(row=2, column=0, pady=(5,0))
        self.country = ctk.CTkEntry(master=self.area.tab("International"), placeholder_text="Please enter your country", width=300, justify="center")
        self.country.grid(row=3, column=0, pady=10)
        # Button
        goButton = ctk.CTkButton(master=self.area.tab("International"), text="Go", width=50, hover=True, command=self.update_gui_int)
        goButton.grid(row=4, column=0, pady=10)
        self.cityInt.bind("<Return>", self.update_gui_int)
        self.country.bind("<Return>", self.update_gui_int)
    # Pre : self.city, should be a real city inside of the corresponding state entered in self.state. If a ZIP is entered, then the ZIP should be valid. If all three are entered, the ZIP should correspond to the city and state.
    # Post : Returns json with weather information in at the given location
    # Purpose : To get weather information at a given location in the US
    def get_weather_us(self):
        weatherString = self.city.get() + ' ' + self.state.get() + ' ' + self.zip.get()
        return gw.get_weather(weatherString)
    # Pre : self.cityInt should be a real city inside of the corresponding country entered in self.country. 
    # Post : Returns json of with weather information in the given location
    # Purpose : To get weather information at a given location internationally
    def get_weather_int(self):
        weatherString = self.cityInt.get() + ' ' + self.country.get()
        return gw.get_weather(weatherString)
    # Pre : None
    # Post : Removes all objects in self.root
    # Purpose : To clear out all items in the root
    def clear(self):
        for item in self.root.winfo_children():
            item.destroy()
    # Pre : None
    # Post : Calls update_gui with the US weather info
    # Purpose : To update the GUI correpsonding to US tab
    def update_gui_us(self, event=None):
        weatherInfo = self.get_weather_us()  # Gets the weather info
        self.update_gui(weatherInfo)
    # Pre : None
    # Post : Calls update_gui with the international weather info
    # Purpose : To update the GUI correpsonding to international tab
    def update_gui_int(self, event=None):
        weatherInfo = self.get_weather_int()  # Gets the weather info
        self.update_gui(weatherInfo)
    # Pre : None
    # Post : Clears prior screen and updates GUI with information about the day's weather including temperature, feels like, humidity, conditions, precipitation, and alerts
    # Purpose : To show the information that is needed for user to know the weather.
    def update_gui(self, weatherInfo):
        self.clear()
        # Extract weather data
        temperature = weatherInfo["days"][0]["temp"]
        humidity = weatherInfo["days"][0]["humidity"]
        feelsLike = weatherInfo["days"][0]["feelslike"]  
        conditions = weatherInfo["days"][0]["conditions"]
        precipAmt = weatherInfo["days"][0]["precip"]
        events = weatherInfo.get("alerts", [])

        # Configure root layout
        self.root.columnconfigure(0, weight=1)
        self.root.columnconfigure(1, weight=1)

        # Back button
        backButton = ctk.CTkButton(
            master=self.root,
            text="< Back",
            width=50,
            hover=True,
            command=self.create_sub_rows,
            anchor="ne",
        )
        backButton.grid(row=0, column=0, pady=(20, 10), padx=20, sticky="w")

        # Location label
        locationLabel = ctk.CTkLabel(
            master=self.root,
            text=weatherInfo["resolvedAddress"],
            width=50,
            font=("Arial", 18, "bold"),
            anchor="center",
        )
        locationLabel.grid(row=0, column=0, pady=(20, 10), padx=20, sticky="n", columnspan=2)

        # Weather Frame
        weatherFrame = ctk.CTkFrame(master=self.root, width=400, height=300)
        weatherFrame.grid_propagate(False)
        weatherFrame.grid(row=1, column=0, padx=20, pady=20, sticky="nsew", columnspan=2)
        weatherFrame.columnconfigure((0, 1), weight=1)

        # Labels and data
        labels = ["Temperature:", "Humidity: %", "Feels Like:", "Conditions:"]
        data = [temperature, humidity, feelsLike, conditions]

        for i, (label, value) in enumerate(zip(labels, data)):
            dataLabel = ctk.CTkLabel(master=weatherFrame, text=label, font=("Arial", 14))
            dataLabel.grid(row=i, column=0, padx=10, pady=5, sticky="e")

            valueLabel = ctk.CTkLabel(master=weatherFrame, text=str(value), font=("Arial", 14, "bold"))
            valueLabel.grid(row=i, column=1, padx=10, pady=5, sticky="w")
            
        # Precipiation
        precipLabel = ctk.CTkLabel(master=weatherFrame, text="Precipitation: ", font=("Arial", 14))
        precipLabel.grid(row=len(labels), column=0, padx=10, pady=5, sticky="e")
        if precipAmt:
            precipType = ""
            for i in range(len(weatherInfo["days"][0]["preciptype"])):
                precipType += weatherInfo["days"][0]["preciptype"][i].capitalize()
                if i < (len(weatherInfo["days"][0]["preciptype"]) - 1): # adds ampersand if there are multiple types of precipitation
                    precipType += " & "
            precipProb = weatherInfo["days"][0]["precipprob"]
            snow = weatherInfo["days"][0]["snow"]
            snowDepth = weatherInfo["days"][0]["snowdepth"]
            typeLabel = ctk.CTkLabel(master=weatherFrame, text=precipType, font=("Arial", 14, "bold"))
            typeLabel.grid(row=len(labels), column=1, padx=10, pady=5, sticky="w")
            
            # Precipitation frame
            precipFrame = ctk.CTkFrame(master=weatherFrame, width=350)
            precipFrame.grid(row=len(labels)+1, column=0, padx=20, pady=20, sticky="n", columnspan=2)
            precipFrame.columnconfigure((0, 1), weight=1)
            
            # Precipitation Chance
            dataLabel = ctk.CTkLabel(master=precipFrame, text="Precipitation Chance: ", font=("Arial", 14))
            dataLabel.grid(row=0, column=0, padx=10, pady=5, sticky="e")
            
            valueLabel = ctk.CTkLabel(master=precipFrame, text=str(precipProb)+"%", font=("Arial", 14, "bold"))
            valueLabel.grid(row=0, column=1, padx=10, pady=5, sticky="w")
            
            # Precipitation Amount
            dataLabel = ctk.CTkLabel(master=precipFrame, text="Precipitation Amount: ", font=("Arial", 14))
            dataLabel.grid(row=1, column=0, padx=10, pady=5, sticky="e")
            
            valueLabel = ctk.CTkLabel(master=precipFrame, text=str(precipAmt)+" in.", font=("Arial", 14, "bold"))
            valueLabel.grid(row=1, column=1, padx=10, pady=5, sticky="w")
            
            if snow:
                # Snow Amount
                dataLabel = ctk.CTkLabel(master=precipFrame, text="Snow Amount: ", font=("Arial", 14))
                dataLabel.grid(row=2, column=0, padx=10, pady=5, sticky="e")
                
                valueLabel = ctk.CTkLabel(master=precipFrame, text=str(snow), font=("Arial", 14, "bold"))
                valueLabel.grid(row=2, column=1, padx=10, pady=5, sticky="w")
                
                # Snow Depth
                dataLabel = ctk.CTkLabel(master=precipFrame, text="Snow Depth: ", font=("Arial", 14))
                dataLabel.grid(row=3, column=0, padx=10, pady=5, sticky="e")
                
                valueLabel = ctk.CTkLabel(master=precipFrame, text=str(snowDepth)+" in.", font=("Arial", 14, "bold"))
                valueLabel.grid(row=3, column=1, padx=10, pady=5, sticky="w")
                
        else:
            typeLabel = ctk.CTkLabel(master=weatherFrame, text="None", font=("Arial", 14, "bold"))
            typeLabel.grid(row=len(labels), column=1, padx=10, pady=5, sticky="w")
            

        # Events frame
        eventsFrame = ctk.CTkFrame(master=weatherFrame)
        eventsFrame.grid(row=len(labels)+2, column=0, columnspan=2, pady=10)
        eventsFrame.columnconfigure(0, weight=1)

        if events:
            eventTitle = ctk.CTkLabel(master=eventsFrame, text="Weather Alerts:", font=("Arial", 14, "underline"))
            eventTitle.grid(row=0, column=0, pady=5)

            for eventRow, event in enumerate(events, start=1):
                eventLabel = ctk.CTkLabel(master=eventsFrame, text=event, font=("Arial", 12))
                eventLabel.grid(row=eventRow, column=0, pady=2, sticky="w")
        else:
            noEventLabel = ctk.CTkLabel(
                master=eventsFrame,
                text="No weather alerts found.",
                font=("Arial", 12, "italic"),
            )
            noEventLabel.grid(row=0, column=0, pady=5)
