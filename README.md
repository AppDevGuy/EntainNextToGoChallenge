# Next To Go App Architecture Document

## Overview
This app is to complete the Next to go challenge required by Entain. 

This document outlines the technical architecture of a SwiftUI application designed using the Model-View-ViewModel (MVVM) pattern, supplemented by a routing mechanism similar to a Coordinator, and utilizing the Combine framework for reactive programming. This structure aims to create a scalable, maintainable, and testable application that separates concerns, enhances the development workflow, and adheres to modern Swift application design principles.

## Architecture Components

### MVVM Pattern

The Model-View-ViewModel (MVVM) pattern is central to the architecture of this SwiftUI application. It divides the app's responsibilities into three core components, each with a distinct role:

- **Model**: Represents the data (Domain) and the business logic of the application. In this app, models are defined within the `Data` and `Domain` folders. The `Data` folder contains the data structures, while the `Domain` folder encapsulates the business logic that operates on the data.
- **View**: Defines the UI of the application. The Views are SwiftUI views that are declarative and react to changes in the ViewModel to update the UI. They are located in the `Presentation` folder.
- **ViewModel**: Acts as an intermediary between the Model and the View. It handles the presentation logic and state management, reacting to user inputs from the View and updating the View with new data by fetching or processing it through the Model. ViewModels are also part of the `Presentation` folder.

The MVVM pattern facilitates a clear separation of concerns, making the codebase more manageable and significantly enhancing testability, particularly when combined with the Combine framework for reactive data binding.

### Router (Coordinator)

A Router, functioning similarly to the Coordinator pattern, is employed to manage navigation and the flow of the application. This component decouples views from their presentation logic, making navigation decisions based on user actions or events. The Router is part of the `Presentation` folder, illustrating its role in managing how the user moves between different parts of the app.

This separation of navigation logic from view code helps in:

- Centralising the navigation logic, making it easier to understand and modify.
- Decoupling views from their navigation context, enhancing reusability.
- Simplifying the testing of navigation logic.

### Combine Framework

The Combine framework is used extensively in this application for reactive programming. It allows the application to process values over time, handle asynchronous events, and manage data streams effectively. Combine is integral to the binding between the ViewModel and the View, enabling the UI to react to changes in state or data seamlessly and efficiently.

Using Combine, the application can:

- Easily perform network requests and handle responses within the `Network` folder.
- Bind UI elements to data models reactively, ensuring that the UI updates are both smooth and efficient.
- Simplify and improve the readability of asynchronous code.

### Application Structure

The application's codebase is organised into several folders, each dedicated to a specific aspect of the app's functionality:

- **Constants**: Stores constant values used throughout the app, such as API URLs and the race expiry seconds.
- **Data**: Contains models that represent the data structures returned from the API.
- **Domain**: Encapsulates the business logic of the application.
- **Network**: Manages network requests to fetch JSON data from endpoints.
- **Presentation**: Houses the Router, Views, and ViewModels.
- **Styles**: Contains files for managing UI styles, including Colors, Fonts, Icons, and ViewModifiers, promoting a consistent look and feel for both Light and Dark modes, as well as offering support for accessibility through scalable, system fonts and ViewModifiers.
- **Utilities**: Includes helper classes and extensions that provide additional functionality needed across the application.

### Localisation, Accessibility and Testing

The application also prioritises localisation, accessibility and testing:

- **Localizable Strings**: Supports multiple languages and regions, ensuring that the app can be easily adapted to meet the needs of various users.
- **Accessibility**: The use of system fonts enables the automatic scaling of font size and weight based on the users own preferences. There also exists accessibility labels and some accesibilty actions. 
- **Testing**: Significant tests are provided for the Domain and Network layers, ensuring that the business logic and data fetching mechanisms are reliable and function as expected.

## Key Development Approaches

I prioritised addressing key issues that I expected would be problematic both technically and for the user experience. Through this process of undertsnaing key issues, I favoured documenting and developing test scenarios to ensure I could write code that would fulfill the requirements.

I use dependency injection, protocols (referred to as interfaces for common language) and small classes to emphasise loose coupling, including in navigation via the use of a Router. 

### Display Time

Understanding the rules for displaying the countdown time and understanding the User Experience challenges associated with this, I prioritised writing tests to accept the epoch time weighed against specific dates and times to achieve the correct display outcomes. 

### Countdown Timer

Having written classes in the past to support timer functionality and firing at correct intervals, I wrote tests and a class to check that I could successfully initiate and determine firing of events had occured by providing both the time interval and a subscribe to the events. This class is used for both the updating of the display and the fetching of new data. 

### Protocols & Dependency Injection

I use protocols and dependency injection to ensure that I can successfully test desired behaviour and ensure that business logic remains unchanged in classes requiring dependency injection. 

### Network, Data Decoding

Understanding the essential information required for display, with additional information beneficial for a basic detail display, I wrote tests using real JSON data to ensure that I could not only emulate a network fetching but ensure that I could handle network and decoding issues in a safe way. 

### Race Filtering

I have written tests to ensure that when specific filters are active or inactive that the results available for display are correct. 

### Error Handling

I have provided default states and error handling states for scenarios such as:

- No network connection
- No data available
- No active filters

### Background & Foreground Activation

I have checks for when entering the background and foreground to disable and enable the timers and network checks to prevent background polling and undesired network and memory usage while the app is not in the foreground.

## Conclusion

This SwiftUI application's architecture, utilising the MVVM pattern with a Router (like Coordinator) and the Combine framework, is designed to be robust, scalable, and maintainable. The organisation into specific folders enhances readability and modularity, while the emphasis on testing and localisation ensures that the app is reliable and accessible to a wide audience.
