# Ruby on Rails API with OAuth Protection and Elasticsearch Integration

## Overview

This project is a Ruby on Rails API that implements OAuth 2.0 authentication using Doorkeeper and provides search functionality using Elasticsearch. 
It manages resources for `Verticals`, `Categories`, and `Courses` with nested API routes.

## Table of Contents

1. [Installation](#installation)
2. [Configuration](#configuration)
3. [Usage](#usage)
   - [Endpoints](#endpoints)
   - [OAuth Authentication](#oauth-authentication)
   - [Search Functionality](#search-functionality)
4. [Testing](#testing)
5. [Known Issues and Limitations](#known-issues-and-limitations)

## Installation

### Prerequisites

- Ruby (version 3.0+ recommended)
- Rails (version 6+ recommended)
- PostgreSQL
- Elasticsearch (version 7.x recommended)
- Bundler

### Steps

1. Clone the repository:
  ```bash
  git clone <repository-url>
  cd <project-directory>
  ```
  
2. Install dependencies:

```bash 
  bundle install 
```

3. Set up the database:

```bash 
  rails db:create db:migrate db:seed 
```
4. Start the Rails server:

```bash 
  rails server 
```
### Usage

#### Endpoints

1. #### Verticals
  - ``` GET /api/v1/verticals```: List all verticals.
  - ``` POST /api/v1/verticals```: Create a new vertical.
  - Requires OAuth token.

2. #### Categories
  - Nested under a vertical: ```GET /api/v1/verticals/:vertical_id/categories.```
  - CRUD operations supported.

3. #### Courses
  - Nested under a category: ```GET /api/v1/verticals/:vertical_id/categories/:category_id/courses.```
  - CRUD operations supported.
  
### OAuth Authentication

1. Obtain an access token using client credentials:

```bash
curl -X POST http://localhost:3000/oauth/token \ -d "grant_type=client_credentials&client_id=YOUR_CLIENT_ID&client_secret=YOUR_CLIENT_SECRET" 
```

2. Use the access token to access protected endpoints:
```bash
curl -H "Authorization: Bearer ACCESS_TOKEN" http://localhost:3000/api/v1/verticals
```

3. Search Functionality
- Search courses using Elasticsearch:
```bash
GET /api/v1/verticals/:vertical_id/categories/:category_id/courses/search?query=YourSearchTerm
```

### Testing
#### Prerequisites
- RSpec and FactoryBot are used for testing.
- Set up the test environment by running:

```bash
rails db:test:prepare
```
#### Running Tests
- Execute all tests:

```bash
bundle exec rspec
```

- Example test cases for API endpoints and OAuth validation can be found in the ```spec/requests``` directory.

### Known Issues and Limitations
- Ensure that Elasticsearch is running when using search functionality; otherwise, searches may fail.
- Token expiration and revocation are handled by Doorkeeper but require client-side management.
- Additional error handling for edge cases (e.g., missing required parameters) is recommended.
