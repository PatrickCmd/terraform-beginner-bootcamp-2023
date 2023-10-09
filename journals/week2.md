# Terraform Beginner Bootcamp 2023 - Week 2

![Week2 Physical diagram](assets/week2-physical-diagram.png)

In week2 we will be building a custom terraform provider with `golang language` which will use to connect our Terra Houses to [Terra Towns](https://terratowns.cloud/) our production server.

The Provider will be used to create a resource for creating, reading, updating, and destroying our terra house in terra towns through the `API endpoints (routes)` as shown in the diagram above.

## Working with Ruby

### Bundler

Bundler is a package manager for runy.
It is the primary way to install ruby packages (known as gems) for ruby.

#### Install Gems

You need to create a Gemfile and define your gems in that file.

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run the `bundle install` command

This will install the gems on the system globally (unlike nodejs which install packages in place in a folder called node_modules)

A Gemfile.lock will be created to lock down the gem versions used in this project.

#### Executing ruby scripts in the context of bundler

We have to use `bundle exec` to tell future ruby scripts to use the gems we installed. This is the way we set context.

### Sinatra

Sinatra is a micro web-framework for ruby to build web-apps.

Its great for mock or development servers or for very simple projects.

You can create a web-server in a single file.

https://sinatrarb.com/

## Terratowns Mock Server
Locally we mocked the Terratowns production server with a mock server using Sinatra.

### Running the web server

We can run the web server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```

Sample Output

```
Use `bundle info [gemname]` to see where a bundled gem is installed.
== Sinatra (v3.1.0) has taken the stage on 4567 for development with backup from Puma
Puma starting in single mode...
* Puma version: 6.3.1 (ruby 3.2.2-p53) ("Mugi No Toki Itaru")
*  Min threads: 0
*  Max threads: 5
*  Environment: development
*          PID: 3594
* Listening on http://127.0.0.1:4567
* Listening on http://[::1]:4567
Use Ctrl-C to stop
```

All of the code for our server is stored in the `server.rb` [file](../terratowns_mock_server/server.rb).

The mock server mocks out the `CRUD` [create, read, update, and delete] operations for our production server.

### Anatomy of a Request
![Anatomy of a request](assets/request-anatomy.png)

An HTTP (Hypertext Transfer Protocol) request is a message sent by a client (typically a web browser or application) to a web server to request a specific resource, such as a web page, image, or data. The anatomy of an HTTP request consists of several components:

1. Request Method: The HTTP request begins with a method or verb that defines the action the client wants to perform on the resource. Common HTTP methods include:
   - GET: Retrieve data from the server.
   - POST: Send data to the server to create a new resource.
   - PUT: Update an existing resource on the server.
   - DELETE: Remove a resource from the server.
   - HEAD: Retrieve headers of a resource without the actual content.

2. Request URL (Uniform Resource Locator): The URL specifies the address of the resource the client wants to access. It includes the protocol (e.g., http:// or https://), the domain name or IP address of the server, the port number (optional), and the path to the resource.

3. Request Headers: HTTP headers provide additional information about the request or the client making the request. Common headers include:
   - Host: Specifies the domain name or IP address of the server.
   - User-Agent: Identifies the client application or browser making the request.
   - Accept: Informs the server about the types of media it can accept in response (e.g., HTML, JSON, XML).
   - Content-Type: Specifies the media type of the data being sent in the request (for POST and PUT requests).
   - Authorization: Contains credentials or tokens for authentication.
   - Cookies: Contains any cookies associated with the domain.

4. Request Body: In some HTTP methods like POST and PUT, a request may include a body that contains data to be sent to the server. This is commonly used for submitting form data, JSON payloads, or other data.

5. Query Parameters: For GET requests, additional parameters can be included in the URL query string to provide more information to the server. For example, in the URL "https://example.com/search?q=keyword&page=2," "q" and "page" are query parameters.

Here is an example of a simple HTTP GET request:

```plaintext
GET /example.html HTTP/1.1
Host: www.example.com
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8
```

In this example, the client is requesting the resource "/example.html" from the server "www.example.com" using the GET method, and it includes various headers to specify how the response should be handled.

HTTP requests and responses are the building blocks of communication on the World Wide Web, allowing clients and servers to exchange data and content seamlessly.

### Testing Mock server using bash scripts
We can test mock server endpoints using the created bash scripts for creating, reading, updating, and deleting a terra house.

#### Creating a terra house
Run the create bash script to create a terra house

```sh
./bin/terratowns/create
```

Outputs the `uuid` of the created house

```
{"uuid":"a22cf824-fc82-4090-958f-a7835f8bcad9"}
```

#### Getting the details of a terra house
To get the details of a particular terra house, run the read bash script using it's `uuid`

```sh
./bin/terratowns/read a22cf824-fc82-4090-958f-a7835f8bcad9
```

Gives

```json
{
  "uuid": "a22cf824-fc82-4090-958f-a7835f8bcad9",
  "name": "New House",
  "town": "gamers-grotto",
  "description": "A new house description",
  "domain_name": "3xf332sdfs.cloudfront.net",
  "content_version": 1
}
```

#### Updating the details of a terra house
To update the details of a particular terra house, run the update bash script using it's `uuid`

```sh
./bin/terratowns/update a22cf824-fc82-4090-958f-a7835f8bcad9
```

#### Deleting the details of a terra house
To delete a particular terra house, run the delete bash script using it's `uuid`

```sh
./bin/terratowns/delete a22cf824-fc82-4090-958f-a7835f8bcad9
```

## CRUD

Terraform Provider resources utilize CRUD.

CRUD stands for Create, Read Update, and Delete

https://en.wikipedia.org/wiki/Create,_read,_update_and_delete
