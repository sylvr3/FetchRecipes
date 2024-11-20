### Steps to Run the App

In the root directory of the project, open the FetchRecipes.xcodeproj file using Xcode and run the app in Xcode using an iOS simulator or physical device of your choice.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

I prioritized and focused on the following areas:

1. Efficient Data Handling - I focused on implementing a solution that minimizes network usage. This includes image caching, which is used to avoid redundant, unncessary downloads and improve app performance. Images are only loaded when needed. This improves responsiveness, as well as speed and bandwidth usage.

2. Swift Concurrency - I used Swift's concurrency model and asynchronous functions (async/await) to make the network requests. This ensures that any updates made to the UI are performed on the main thread without blocking the UI.

3. Error Handling - I made sure that the app handles malformed data or empty responses. Instead of showing an unhandled crash or an empty list of recipes without context, the app shows an error message for malformed data and shows a "No recipes are available" message when the data is empty.

4. UI/UX - I focused on making the user interface simple and intuitive. The UI consists of a list of recipes that shows the name, cuisine type, and photo. It also has a Play button that allows you to play the YouTube video associated with a particular recipe, as well as a button that says View Recipe that allows the recipe to be viewed by opening the source URL. There is a pull-to-refresh gesture to allow the user to reload the recipe list manually. Error states and empty states are handled using clear messages.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I spent 5 hours on this project. I did not complete it in one sitting; I spent 1-2 hours each day the past few days to complete it.

I allocated my time by first spending 1 hour planning how I was going to implement my app. I designed my app using the MVVM architectural design pattern, creating groups and modules for each of the different components (models, service, views, viewModels, etc).
I spent 1.5 hours implementing the model classes, NetworkService class used to retrieve the recipe data from the REST API and working with asynchronous functions to retrieve and display the data in a thread-safe manner.
I spent 1.5 hours building the UI to display the list of recipes, creating the image caching service to cache the images and improving the user experience of the app with enhancements on the UI, such as a Play button on the recipe image to play the YouTube video for the corresponding recipe, as well as another button that allows the user to view the recipe and navigates to the source URL from the REST API.
I spent 1 hour writing and performing unit tests for performing network requests on the 3 URLs from the API that were provided, as well as updating the documentation in the code and the README file.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

I decided to implement my own solution for image caching instead of using a third party library. This allowed me to make the caching mechanism more suitable for the app's needs and requirements.
For asynchronous network requests, I used the async/await methods provided in Swift instead of a third party library. This comes with a trade-off in terms of backward compatibility, but should support Swift projects with an iOS version of 15 or higher.

### Weakest Part of the Project: What do you think is the weakest part of your project?

I believe the weakest part of my project is the error handling. Although I did provide basic error handling and informed the user when something goes wrong with error message, I could have also used retry logic or network status feedback.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?

No external libraries or dependencies were used in this project. I implemented everything using native Apple frameworks including Foundation, SwiftUI, and Swift concurrency.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

Performance Considerations:
  - I optimized the image loading to only download images when they are about to appear on the screen. I also made sure to cache images to disk to avoid unnecessary downloads and improve the performance and loading time of the images on the app.
  - I used a custom cache that holds images for a reasonable amount of time. It cleans up old entries when needed.

Network Handling:
  - The app performs asynchronous network requests to avoid blocking the main thread.
  - If the recipe list is empty or malformed, the app provides feedback to the user with an appropriate message.

### Code Structure Overview

Actors
- RecipeListActor.swift: Used to manage state safely using Swift concurrency.

Models
- Recipe.swift: Defines the properties of a recipe (name, photo URL, cuisine type, source URL, YouTube URL, etc).

ViewModels
- RecipeListViewModel.swift: Handles the business logic and interacts with the NetworkService to fetch recipe data.

Service
- ImageCacheService.swift: Manages image caching to reduce bandwidth usage and improve app perforamnce.
- NetworkService.swift: Handles making network requests and parsing the responses using async/await.
- RecipeListResponse.swift: Used for retrieving response and decoding it after asynchronous network requests are performed.
  
Utils
- Constants.swift: Handles the URLs that were used to process various JSON files.
- ImageCacheServiceError.swift: Enum used to process different types of errors related to caching images.
- NetworkError.swift: Enum used to handle errors related to network issues.

Views
- CachedImage.swift: Downloads and stores the image that was cached and displays it in a UIImage View. 
- RecipeListView.swift: A view that displays the list of recipes. Allows users to pull-to-refresh and handles errors.
- RecipeCell.swift: Customized individual cells that include graphical components in each row, as well as UI functionality for actions for each item in the recipe list.

### Unit Tests

I wrote unit tests for the following components:

Network Layer (Network Service)
   - This tests that the Network Service correctly fetches data from the API and handles errors appropriately (for example: empty data or malformed data).
