#  DogList
## App
DogList gets a list of dogs and displays their image and supporting information

## Build and Run
* Xcode 11 & Swift 5. Minimum version is iOS 12
* Open DogList.xcproj

## Testing
* Run UnitTests on a iOS 13 simulator

## Architecture
### MVVM Architecture
* ViewModel contains the business logic, requests data from the local API
* ViewModels communicate with the ViewController using the delegate pattern. The ViewModel has a weak reference to a ViewModelDelegate which the ViewController implements.
* ViewModel communicates with the API via Actions. Action is an abstraction to a Service. The Action abstraction is used to mock the service in testing ViewModels. 
* Tests make use of a Service stub to mock behavior. It uses a Delegate spy to verify interactions with the ViewController

### DogListService
* Responsible for communicating with the APIs and coordinating requests and responses. 
* Uses DispatchQueues to perform the processing in the background, since the APIs are asynchronous and it shouldn't be run on the Main queue. 
* DogListResponse is a domain transfer object that's separate from the Dog model that the app is using. This is to allow for the API response to evolve in structure and data independent of the app's models.

## 3rd Party Dependencies
* Swift Package Manager for dependency management
* Kingfisher 3rd party library for asynchronously fetching of images. This is done behind and UIImageView extension which makes it easier to swap it with a different 3rd party or refactor into something bespoke for the app.
* SnapKit for AutoLayout constraints. This can be replaced by using the iOS native frameworks.
* BrightFutures for handling asynchronous code. An alternative is using blocks or delegate pattern.


## Assumptions
* Lifespan years have only 2 valid formats: "x - y years" and "z years". Any other format would either result to wrong or invalid data. 
* When the lifespan is in range form, it's average is used for comparisons.
* When handling data in an array that is malformed or invalid, that data isn't included in the response and no error is raised. This is to simplify the implementation. This behavior can be modified in the DogListService mapping. 

## Notes
* Uses Swift's Standard Library's Decodable and JSONDecoder for parsing
* Displays a placeholder image if there was an issue in getting the image
* print is used as a substitute with logging non fatal errors or issues.
* There is only 1 error enum: DogListError which is done for simplicity. This can be improved by splitting it out by layer from Networking to Service to DataProcessing.

