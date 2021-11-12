# Gas Station Finder
This is the IMPARGO test task for the Product Engineer (Mobile) position.

One common problem for truck drivers on the road is that they need to find certain points-of-interest (POIs) in their proximity. For example they might search for the closest parking spot for the night or the next gas station. Let’s assume we want to build an app to retrieve and display all gas stations close to a user.

The requirement is a mobile application (using flutter) where users can find the nearest gas stations based on their current location. No input is needed from the users other than a permission to view their current location. The nearby gas stations can be fetched using [HERE places API](https://developer.here.com/documentation/places/dev_guide/topics/explore-by-category.html). The results should also include the ETA from the users current location to each of the gas stations. You will find below the designs for the mobile app, including a Figma prototype.

## Requirements
- `location_access`: A welcome screen to ask the users for location permission.
- `station_list`: A screen with a title, a refresh button, and a list of the nearby gas stations, each including the ETA. While the list is retrieved from the API a loading indicator should be shown.
- A working application on Android 10, Android 11, and Web. The application does not need to run on IOS.

The project already contains some boilerplate with the basic navigation in `./lib/main.dart` and the two views `./lib/location_access.dart` and `./lib/station_list.dart`. For widget testing there is one example `./test/location_access_test.dart` widget test.
Feel free to adapt the existing code structure whenever needed.  

## Designs
- [Figma file](https://www.figma.com/file/j95KOS39xpV1bA9WaZHt2I/Gas-Station-Finder?node-id=0%3A1).
- [Prototype](https://www.figma.com/proto/j95KOS39xpV1bA9WaZHt2I/Gas-Station-Finder).

## Notes
- The following HERE API key can be used: `2xhBNx1OyjfMVs1iZoJeMzUO6bFvPhYMQ3PuuTNgP_s`
- The deadline for the task is 3 days.
- Make sure to include widget and unit tests for the implemented logic. Boilerplate for the testing is already available in the test directory. 
- See github actions for some insights if your code builds and all tests pass.
- Once you are done, you should commit your changes to a different branch and make a pull request.
