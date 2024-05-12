Hi! This is my WeatherApp

1. How app looks:

   
   <img width="437" alt="Zrzut ekranu 2024-05-12 o 12 17 09" src="https://github.com/Ziemowit02K/WeatherApp/assets/106156554/3cfe5a27-dab7-4143-8df0-89142542c865">
   <img width="481" alt="Zrzut ekranu 2024-05-12 o 12 17 20" src="https://github.com/Ziemowit02K/WeatherApp/assets/106156554/638ef887-5c19-428d-b900-2e811213fe01">
   <img width="481" alt="Zrzut ekranu 2024-05-12 o 12 17 31" src="https://github.com/Ziemowit02K/WeatherApp/assets/106156554/ccaee5cf-b028-43d5-a864-998a187907ac">

   


2. How the app work:
   
   This weather app is using openweathermap.org API to find weather data from certain location (in cordinates). To change cordinates to names of the city
I used GeoLocation API (from openweathermap.org too), so the app translates name in string to cordinates in Int and pass it 
to weather API and get nessesery data. Whole UI is my own idea and I hope it will stand.

3. To make it work:
   
  To make it work all you need to do is head to this awesome side:

  ->https://openweathermap.org

  and get your own API_Key. Then all you have to do is find let apiKey="" (WeatherApp/API_SERVICE/API_SERVICE.swift) and paste your own key.
  It schould work then. 




