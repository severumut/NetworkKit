

# NetworkKit

NetworkKit is a lightweight, flexible, and modern Swift networking package built with Swift Concurrency and Protocol-Oriented Programming principles.

It provides a clean and scalable way to manage network requests and responses without relying on UIKit or SwiftUI, making it ideal for both iOS and server-side Swift projects.

---

## Description

NetworkKit allows you to define your API endpoints, requests, and response models while handling errors gracefully using `async/await` and `Result` types.

Designed to be extendable and easily customizable to fit any project structure.

---

## Technologies Used

- Swift 5.9+
- Swift Concurrency (`async/await`)
- Protocol-Oriented Programming
- URLSession
- Result Type
- Swift Package Manager (SPM)

---

## Installation

You can install NetworkKit via Swift Package Manager (SPM):

1. Open your project in Xcode.
2. Go to `File → Swift Packages → Add Package Dependency`.
3. Enter the repository URL:

```
https://github.com/severumut/NetworkKit
```

4. Choose the version and complete the setup.

---

## Features

- ✅ Fully `async/await` based request handling
- ✅ Flexible Request and Endpoint definitions
- ✅ Result type (`success`/`failure`) based responses
- ✅ Customizable Request body, query, and header handling
- ✅ Centralized error management (`NetworkError`)
- ✅ Lightweight and easy to integrate

---

## Example Implementation

Let's create a simple example to see how to use `NetworkKit` effectively.  
We will define a new endpoint, a request, a response model, and a service to fetch the data.

---

### 1. Define an Example Endpoint

```swift
import NetworkKit

public enum ExampleEndpoint: EndpointProtocol {
    case sample
    
    public var baseURL: String {
        "exampleapi.com/api/v1"
    }
    
    public var path: String {
        switch self {
        case .sample: return "sample"
        }
    }
}
```

---

### 2. Define an Example Request

```swift
public enum ExampleRequest: Request {
    case sample
    
    public var endpoint: any EndpointProtocol {
        switch self {
        case .sample: return ExampleEndpoint.sample
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .sample: return .GET
        }
    }
}
```

---

### 3. Define an Example Response Model

```swift
public struct ExampleResponse: Decodable, Sendable {
    public let id: Int?
    public let name: String?
}
```

---

### 4. Define an Example Service

```swift
public protocol ExampleServiceProtocol: Sendable {
    func fetchExample(request: ExampleRequest) async -> Result<ExampleResponse, NetworkError>
}

public final class ExampleService: ExampleServiceProtocol {
    
    private let client: ClientProtocol
    
    public init(client: ClientProtocol = Client()) {
        self.client = client
    }
    
    public func fetchExample(request: ExampleRequest) async -> Result<ExampleResponse, NetworkError> {
        return await client.fetch(request: request, ExampleResponse.self)
    }
}
```

---

## Example Usage

Now let's see how to use the `ExampleService` to fetch the data in an async environment:

```swift
let service = ExampleService()

Task {
    let result = await service.fetchExample(request: .sample)
    
    switch result {
    case .success(let response):
        print("Fetched Example: \(response)")
    case .failure(let error):
        print("Error: \(error.localizedDescription)")
    }
}
```

---

## License

This project is licensed under the MIT License.  
Feel free to use, modify, and distribute it!

---

## Author

Created by [Umut Sever](https://github.com/severumut)
