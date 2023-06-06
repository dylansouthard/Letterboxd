# Letterboxd

This is an unofficial Swift wrapper for the [Letterboxd API](https://api-docs.letterboxd.com/). It provides a convenient way to integrate your Swift applications with Letterboxd's services, offering functions for common API endpoints.

## Table of Contents
1. [Installation](#installation)
2. [Usage](#usage)
3. [Limitations](#limitations)
4. [Contributing](#contributing)
5. [License](#license)

## Installation

To install this Swift package, please follow these steps:

1. Open your Swift project in Xcode.
2. Go to File -> Swift Packages -> Add Package Dependency.
3. Enter the repository URL of this Swift package.
4. Choose the version range that suits your needs.
5. Add the Letterboxd Swift Wrapper to the desired target in your project.

## Usage

Here are some examples of how to use the Swift wrapper for various Letterboxd API endpoints:

### Authentication

```swift
import Letterboxd

// Set up your API key and secret. This must be called before any requests are made.
Letterboxd.configure(apiKey: "yourApiKey", apiSecret: "yourApiSecret")

// Fetch Auth token
Letterboxd.fetchAuthToken(username: "username", password: "password")
```

### Fetching Data

```swift
import Letterboxd

// Fetch a specific film's details
Letterboxd.fetchFilm("filmId") { result in
    switch result {
    case .success(let film):
        print(film.name)
    case .failure(let error):
        print(error.localizedDescription)
    }
}

// Fetch a member's details
Letterboxd.fetchMember("memberId") { result in
    // Handle result...
}
```

### Request Parameters
Most of the API methods provided by this SDK include an optional `params` argument that lets you specify a variety of parameters to filter and sort the data returned from the Letterboxd API. These parameters are defined in the `LBParams` extension. 

Let's take a look at the `LBParams.Films` structure as an example:

```swift
extension LBParams {
    public struct Films: LBParamConvertible {
        ...
    }
}
```


More detailed documentation on each endpoint can be found in the source code.

## Limitations
This Swift wrapper is a work in progress and currently does not provide full coverage of the Letterboxd API. The package supports all available requests, mainly GET requests and the POST request for generating an authentication token. However, many of the API's endpoints are still under development by Letterboxd. As these endpoints become available, they will be added to this package.

While the basic functionality of the package has been tested, not every possible parameter for every request has been extensively tested. If you encounter any issues or unexpected behavior, please feel free to raise an issue or submit a pull request.

## Contributing
Contributions are welcome, especially as I have not had the opportunity to thoroughly test all functionality! Please submit a pull request with any enhancements.

## License
This project is licensed under the MIT License, which permits use, distribution, and modification, but does not allow users to claim ownership of the project or use it for direct commercial advantage.
