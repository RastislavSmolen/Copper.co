# Copper.co
Copper.co core data + concurrency test 

I have tried to do everything on the list. I was not able to implement few features requested by the file. API was not providing data specified on the desing document. For example data whas not specifing if the data is going in or out/ minus or plus therefore I was unable to sort the data as expected. I hope that is ok.
So I had skip this. I would go to back end developer and asked what is going on.I like to follow MVP(minimum viable product).And scale the solution as is needed.

# What I would change

I went with simple solution MVC and one unit test to prove testability of the code. If this was a real project. I would go with testing every call ther is . I have tried to keep it nice simple and light. I went with generics in networking so we dont care what kind of data we are parsing. I would have implemented linting for clean code. For more complicated app I would have implemented MVVM with coordinator for separation. Depending on needs of the the project I would go with .xib as storyboard can get slow with multiple screens. In the future I would create utitlities folder for scalable ui that are used across the app to make it quick to reuse and implement.

## Requirements
1. Built with Xcode 11.7
2. iOS 13 and up

## How to run the app?
1. Clone the repo on a macOS with Xcode 11.7 installed
2. Open the 'Copper.xcodeproj' file on a macOS with Xcode 
3. Use CMD + R or Product -> Run.

## Notes
1. The app caches the API response and uses it on subsequent API calls.
3. Used MVVC pattern.
4. Adapts to Light/Dark mode with a breeze.

## Future Improvements
1. Search/filter feature based on the desired outcome.
2. Add UI tests for each individual use cases.
3. Adapt Accessibility
4. Adapt Dynamic Type
