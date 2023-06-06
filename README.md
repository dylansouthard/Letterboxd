# Letterboxd

This is an unofficial Swift wrapper for the [Letterboxd API](https://api-docs.letterboxd.com/). It provides a convenient way to integrate your Swift applications with Letterboxd's services, offering functions for common API endpoints.

## Table of Contents
1. [Installation](#installation)
2. [Usage](#usage)
3. [Contributing](#contributing)
4. [License](#license)

## Installation

[TODO]

## Usage

Here are some examples of how to use the Swift wrapper for various Letterboxd API endpoints:

### Authentication

```swift
// Set up your API key and secret. This must be called before any requests are made.
Letterboxd.configure(apiKey: "yourApiKey", apiSecret: "yourApiSecret")

// Fetch Auth token
Letterboxd.fetchAuthToken(username: "username", password: "password")
```

### Fetching Data

```swift
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

More detailed documentation on each endpoint can be found in the source code.

## Contributing
Contributions are welcome, especially as I have not had the opportunity to thoroughly test all functionality! Please submit a pull request with any enhancements.

## License
[TODO]
