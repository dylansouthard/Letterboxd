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

The module must be configured with your API key, API secret, and your unique keychain service name (used to store and retrieve access token data) before use:
```swift
import Letterboxd

// Set up your API key, secret, and keychain service name. This must be called before any requests are made.
Letterboxd.configure(apiKey: "yourApiKey", apiSecret: "yourApiSecret", keychainService: "yourKeychainServiceName")
```

### Authorization
This package manages the authentication process for you. If a request is made with an expired token, the The API token, it will automatically attempt another using the refresh token. The initial token can be generated as follows:
```swift
Letterboxd.fetchAuthToken(username: "username", password: "password")
```

 When making API requests, certain calls might require the user to be authenticated. In such cases, authorization will be required by default.

However, for certain API calls that can return different results based on the authentication state, the `forceAuth` parameter can be set. These requests will include authentication if available, even if `forceAuth` is not specifically set to `true`.

If you want to ensure that a request only proceeds when the user is authenticated, you can set `forceAuth` to `true`. Here's an example:
```swift
Letterboxd.fetchFilms(params: yourFilmParams, forceAuth: true) { result in
    // Handle result
}
```

When `forceAuth` is set to `true`, the request ensures that the user is authenticated with a valid access token. If the current token is expired, it will automatically attempt to generate a new one using the refresh token provided during the initial authentication process.

If the user is not logged in, or a new token cannot be generated, the function will return an error of type `LetterboxdError.noToken`. If a request returns a `.noToken` error, you can handle it accordingly (by prompting the user to log in, etc.)

`LetterboxdError` is an enum which provides comprehensive and descriptive error messages to help troubleshoot issues related to API requests. For more details on this, refer to the `Errors.swift` file in the package source code.

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
The `LBParams.Films` struct is used to specify parameters for filtering and sorting a list of films. You can specify criteria for the films to retrieve, define the relationship with a member, specify a tag, set pagination settings for the retrieved list, and determine the sorting rule for the retrieved list.

The `LBParams.Films` structure includes several nested structures to specify further detail in parameters such as `FilmParams` and `Genre`.

For example, `FilmParams` lets you set criteria for filtering and searching for films:
```swift
public struct FilmParams: LBParamConvertible {
    ...
}
```

You can specify a list of film IDs to search for, set genre parameters, define region parameters, set release date parameters, determine the film service to use for searching films, and apply additional filters when searching for films.

Similarly, the `Genre` structure specifies the genre parameters for filtering films:
```swift
public struct Genre: LBParamConvertible {
    ...
}
```

You can specify a single genre to filter by, include a list of genres in the results, and exclude a list of genres from the results.

These parameters are then used when making requests. For example:
```swift
Letterboxd.fetchFilms(
    params: LBParams.Films(
        films: FilmParams(
            filmIDs: ["123", "456"],
            genre: Genre(
                genre: .action,
                includeGenres: [.adventure, .comedy],
                excludeGenres: [.horror]
            ),
            region: Region(...),
            releaseDate: ReleaseDate(...),
            service: .netflix,
            filters: [.released, .notInWatchlist]
        ),
        member: FilmMemberRelationship(...),
        tag: Tag(...),
        pagination: Pagination(...),
        sortBy: .filmPopularity
    ),
    forceAuth: false, 
    handler: { result in
        // Handle result
    }
)
```
In the above request, we are fetching films with IDs "123" and "456" in the action genre, including adventure and comedy genres, and excluding the horror genre. We also apply various other filters and sorting rules. Note how each parameter category (like films, genre, region, releaseDate, etc.) have their own respective structs that are used to create a parameter object that conforms to the `LBParamConvertible` protocol.

Remember that each parameter structure includes its own unique set of properties that allow you to customize your requests to the Letterboxd API. For more information on each parameter structure and the properties it includes, please refer to the [API documentation](https://api-docs.letterboxd.com/).


More detailed documentation on each endpoint can be found in the source code.


## Limitations
This Swift wrapper is a work in progress and currently does not provide full coverage of the Letterboxd API. The package supports all available requests, mainly GET requests and the POST request for generating an authentication token. However, many of the API's endpoints are still under development by Letterboxd. As these endpoints become available, they will be added to this package.

While the basic functionality of the package has been tested, not every possible parameter for every request has been extensively tested. If you encounter any issues or unexpected behavior, please feel free to raise an issue or submit a pull request.


## Contributing
Contributions are welcome, especially as I have not had the opportunity to thoroughly test all functionality! Please submit a pull request with any enhancements.


## License
This project is licensed under the MIT License, which permits use, distribution, and modification, but does not allow users to claim ownership of the project or use it for direct commercial advantage.
