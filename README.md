#  safeTest

## How to run the app
 
- Open the file safeTest.xcodeproj
- On the target safeTest > Signing & Capabilities, set the correct team fos signing
- Select target where to run
- Run

## Features

- The app on opening fetches the current weather based on the device's location
- The latest weather data is stored in the Realm persistency. If the device location cannot be retrieved or there's a network problem, the last weather data is presented
- In the app the weather data refresh can be triggered via websocket from the URL:
https://piehost.com/websocket-tester?url=wss%3A%2F%2Ffree.blr2.piesocket.com%2Fv3%2F1%3Fapi_key%3DA6smxWt7ROL3xksSjwoGtrwfbwmFnG8pagM7ppju%26notify_self%3D1
    - open the link in the browser
    - press 'Connect'
    - write 'updateCurrent' in the place of 'Hello PieSocket!'
    - press 'Send'

## What is missing

- Current weather image is not cached, so in case of no network present the image is blank
- Proper error handling, loading and UI messages
