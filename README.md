# eyego_assignment

This is a movies app as an assignment for Eyego Solutions.

## Project Overview

This project is a simple movie app that implements various topics, including: Firebase, Clean Architecture Principles, State Management, and RESTful APIs.

## Project Implementation Approach

This project is built following the Clean Architecture principles, which aims to increase the readability and testability of the project.

## Project Structure

The project includes 4 features:

1.  **User Authentication:** Handles user login and registration.
2.  **Movies & Genres Fetching:** Fetches movie and genre data from a remote API.
3.  **Searching and Filtering:** Allows users to search and filter movies.
4.  **Movie Details:** Displays detailed information about a selected movie.

Based on Clean Architecture principles, each feature is structured as follows:

1.  **Domain Layer:**
    * Contains the core business logic of the feature, entities, and repositories.
    * **Note:** In this project, use cases have been omitted due to the simplicity of the application's business logic.
2.  **Data Layer:**
    * Contains data retrieval and manipulation functions and logic.
    * Interacts with remote data sources like Firebase and RESTful APIs.
    * Includes domain repository and entity implementations, along with data sources that communicate with external frameworks.
3.  **Presentation Layer:**
    * Handles the visual presentation of data, user interfaces, and user experience (UI & UX).
    * Implements state management logic to maintain the data retrieved from the data layer.

## Tools Used in This Project

* **State Management:** `Bloc` (Cubit)
* **Data Sources:**
    * **Remote API:** TMDB API is used for movies & genres data fetching.
    * **Firebase:** Used for user authentication.
* **Responsiveness:** The project UI is designed to be responsive using `Expanded`, `AspectRatio`, and `Flex` widgets.

## Project Setup Instructions

1.  **Flutter Installation:** Ensure that the `Flutter` SDK is installed and configured on your computer.
2.  **GitHub:** Clone the project using the following command:
    `
    git clone https://github.com/ahmedali221/EyeGo_assignment.git
    `
3.  **Dependency Installation:** Run the following command to install the required dependencies:
    `
    flutter pub get
    `
