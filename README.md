# Baluchon



## Intro
Baluchon is an iOS travel application that allows you to convert currency, translate language and get the weather.

## SetUp
To edit the code, just clone the repo.

To use it, please register with the API provider used : 

▸ https://fixer.io/

▸ https://openweathermap.org/api

▸ https://cloud.google.com/translate/docs/apis


You will have to define the key value received on ApiKeys.plist file (git ignored) file for apiCurrency, apiWeather and apiTranslate


This app is not available on the App Store.

## Features
Baluchon is a three-page application iOS that allows:

▸ to get the exchange rate between the dollar and the euro,

▸ to translate from french into english, from english into french, from detected language into french

▸ Compare the weather between two destinations 


## Code Architecture
The code architecture is in MVC.

▸ To navigate between the pages, a tab bar is used, each tab corresponds to one of the three pages described above.

▸ During network calls in the application, if an error occurs, an alert is presented in the form of a pop-up using the class UIAlertController

▸ The following APIs were used: fixer.io, Google Translate and OpenWeathermap.




## Credits
Mélanie OBRINGER - 2019
