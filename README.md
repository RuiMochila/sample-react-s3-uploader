# Sample Presigned S3 Uploader with React and Rails

## Getting Started

This is a Work in Progress

This is a Rails 6 project with a small image uploading feature, showcasing ReactJs, a Rails API, and CableReady to update the client efficiently using websockets. This project features an integration with Amazon S3 and Lambda functions in order to generate image thumbnails. It also shows how to use use Rails concerns at the route, model and controller levels, and service objects, in order to encapsulate and reuse behaviour, and how polymorphic associations can be used in this context.

TODO: Instructions on how to setup the S3 bucket

TODO: Instructions on how to setup the Lambda function to process image thumbnails. 

The Lambda function was coded using NodeJs 12.18.1, it can be found in the root of the project, under ProcessImage.js (node modules list soon).

Additional work is required describing how to setup the deployment pipeline, and a way to test the it locally. 
In order to test this using a Live Lambda function, `ngrok` is advised. 

## Run

To run this project use

```
rails s -b 0.0.0.0
bin/webpack-dev-server
```

Or install foreman and use the Procfile


### Prerequisites

TODO: Add docker configuration


## Deployment

Add additional notes about how to deploy this on a live system


## License

This project is licensed under the MIT License

