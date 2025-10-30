# SwiftUI-Ratings

A Swift Package that provides an elegant and customizable ratings interface for your iOS and macOS applications.

<img src="https://github.com/user-attachments/assets/da8bdd08-5956-40aa-88b2-0d5698d8dac6" width="600">
<img src="https://github.com/user-attachments/assets/17c7bd7e-d8ea-4d92-8d58-86aaad8d18a7" width="600">

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
  - [Swift Package Manager](#swift-package-manager)
- [Usage](#usage)
  - [Basic Implementation](#basic-implementation)
  - [Creating a Custom Rating Provider](#creating-a-custom-rating-provider)
  - [Using the Mock Provider](#using-the-mock-provider)
  - [Using with Supabase and App Store Connect API](#using-with-supabase-and-app-store-connect-api)
- [Customization](#customization)
- [Contributing](#contributing)

## Overview

SwiftUI-Ratings makes it easy to add a ratings and review system to your application. It offers a complete UI for displaying app ratings and reviews, and provides a streamlined way for users to submit their ratings to the App Store.

## Features

- **Rating Request Screen**: A polished UI that displays app ratings, reviews, and encourages users to rate your app
- **Customizable Provider**: Easy integration with any data source through the `AppRatingProviding` protocol
- **Mock Implementation**: Ready-to-use mock data provider for development and preview purposes
- **Error Handling**: Built-in error states with customizable error handling
- **SwiftUI Design**: Modern UI built with SwiftUI for iOS 17+ and macOS 14+

## Requirements

- iOS 17.0+ / macOS 14.0+
- Swift 6.0+
- Xcode 15+

## Installation

### Swift Package Manager

To integrate SwiftUI-Ratings into your Xcode project using Swift Package Manager, add it to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/Sedlacek-Solutions/SwiftUI-Ratings.git", from: "1.0.1")
]
```

Or add it directly via Xcode's Package Manager integration.

## Usage

### Basic Implementation

```swift
import SwiftUI
import Ratings

struct RatingsView: View {
    var body: some View {
        RatingRequestScreen(
            appId: "YOUR_APP_ID",
            appRatingProvider: YourAppRatingProvider(),
            primaryButtonAction: {
                // Handle when user has requested to leave a rating
                print("User tapped to leave a rating")
            },
            secondaryButtonAction: {
                // Handle when user decides to rate later
                print("User will rate later")
            },
            onError: { error in
                // Handle any errors that occur
                print("Error occurred: \(error)")
            }
        )
    }
}
```

### Creating a Custom Rating Provider

Implement the `AppRatingProviding` protocol to fetch ratings and reviews from your backend service:

```swift
struct YourAppRatingProvider: AppRatingProviding {
    func fetch() async throws -> AppRatingResponse {
        // Implement your logic to fetch ratings from your backend
        // For example:
        let (data, _) = try await URLSession.shared.data(from: yourBackendURL)
        return try JSONDecoder().decode(AppRatingResponse.self, from: data)
    }
}
```

### Using the Mock Provider

SwiftUI-Ratings comes with a `MockAppRatingProvider` for testing and UI development:

```swift
RatingRequestScreen(
    appId: "YOUR_APP_ID",
    appRatingProvider: MockAppRatingProvider.withMockReviews
)
```

Available mock configurations:
- `.withMockReviews`: Provides a set of sample reviews
- `.noReviews`: Shows ratings without reviews
- `.noRatingsOrReviews`: Empty state with no ratings or reviews
- `.throwsError`: Simulates an error state

### Using with Supabase and App Store Connect API

For detailed instructions on how to create a Supabase Edge Function that fetches data from the App Store Connect API for use with SwiftUI-Ratings, see our [Supabase Implementation Guide](SUPABASE-GUIDE.md).

## Customization

SwiftUI-Ratings provides a flexible way to tailor the ratings interface through two main customizers: the configuration settings and the screen initializer.

1. RatingScreenConfiguration  
This struct allows you to customize the visual and textual components of the rating screen. Its initializer provides the following properties:

• screenTitle – The main title displayed at the top of the screen (default is localized as "Help Us Grow").
• primaryButtonTitle – The label for the primary action button (default is "Give a Rating").
• secondaryButtonTitle – The label for the secondary action button (default is "Maybe Later").
• memojis – An array of SwiftUI Images that are shown on the screen. A set of default memojis is provided (via .defaultMemojis).

Example usage:
```swift
// Basic customization using RatingScreenConfiguration
let config = RatingScreenConfiguration(
    screenTitle: "Rate Our App",
    primaryButtonTitle: "Rate Now",
    secondaryButtonTitle: "Maybe Later",
    memojis: [Image("happy"), Image("excited")]
)
```
2. RatingRequestScreen Initializer  
This view combines the configuration with data fetching and user actions. Its initializer accepts:

• configuration – An instance of RatingScreenConfiguration to dictate UI appearance.
• appId – The App Store identifier of your app.
• appRatingProvider – An object conforming to AppRatingProviding that fetches ratings data.
• primaryButtonAction – A closure executed when the primary button is tapped (for instance, to open the App Store review page).
• secondaryButtonAction – An optional closure for handling the secondary button tap (typically for deferring the rating process).
• onError – An optional error handler closure for managing any issues during data fetching.

Example initialization:
```swift
RatingRequestScreen(
    configuration: config,
    appId: "YOUR_APP_ID",
    appRatingProvider: YourAppRatingProvider(),
    primaryButtonAction: {
        // Action when the primary button is tapped
        print("User started rating process")
    },
    secondaryButtonAction: {
        // Action when the secondary button is tapped
        print("User chose to rate later")
    },
    onError: { error in
        // Handle any errors that occur
        print("Error encountered: \(error)")
    }
)
```
Both initializers come with default values for common settings, making it easy to either use the standard configuration or fully customize the experience to match your app's style and workflow.

3. Advanced Button Styling with .tint  
Since RatingRequestScreen is built on SwiftUI, you can further customize the appearance of the buttons by applying SwiftUI modifiers. For example, use the .tint modifier to change the color of the primary and secondary buttons:

```swift
// Applying tint to the RatingRequestScreen view
RatingRequestScreen(
 configuration: config,
 appId: "YOUR_APP_ID",
 appRatingProvider: YourAppRatingProvider()
)
.tint(.blue) // This changes the accent color for buttons and interactive elements
```

You can replace .blue with any Color value to match your app's theme.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.
