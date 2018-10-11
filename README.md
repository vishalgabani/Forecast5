# Forecast5

#### Requirements
- Xcode10, iOS 12, Swift 4.1, macOS 10.13.6

#### Steps to run
1. Download or clone the repo
2. Build the code for iPhone XR simulator
3. Run the app
4. Voila!!!  App is running :)

#### Thoughts
- UI is designed using screen specs of iPhone XR
- Weather details can be accommodate in one view to make UX better. There is no need to make multiple views to force user to touch on screen.
- Few controls, clear text and supporting icons are enough to make the app intuitive.

#### Notes
- There were not many tasks to do with third party Networking or UI library so did not use any.
- Provided API link does not give response as expected. Passing lat-long of current location does not make any change in response. It gives same city data in response everytime. It shows data from Feb-2017. This does not mean app is not fetching current location. It fetches current location everytime app launched.


#### Features if had more time
 - Use app icon
 - Use icons based on weather conditions like sunny, cloudy or rainy
 - Use better API to get accurate and current data
 - Add test cases to make it robust
