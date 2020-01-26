# app-sample-ruby-sinatra

vcita OAuth sinatra sample app
==========================

This tutorial describes how to build a simple app that works with vcita's OAuth and OpenID protocols to generate access tokens for you vcita data:

  - Getting OAuth2 Bearer Token
  - Getting User Info
  - Getting a List of Clients
 
 If you are not familiar with the OAuth protocol, please refer to [OAuth 2 Simplified](https://aaronparecki.com/oauth-2-simplified/) for general information on OAuth.
 
### Installation

After cloning the repository, you will need to install the required libraries, run:

    $ bundle install

    
### Setting up the code

In order to create an app that works with vcita OAuth, the first step is to set the clientID and clientSecret in the app.rb file. You are going to also need to uncomment the correct AUTH_SERVER and API_SERVER constants depending on which environment you are developing against.

Note: In order to get a CLIENT_ID and CLIENT_SECRET you will need to have an Application registed with vcita.


### Running the server (locally)

    $ bundle exec ruby app.rb -p 44444

At this point you should be able to go to http://localhost:44444 and start the OAuth process. You will first be redirected to the authorization endpoint where  you grant your app approval to access your vcita data. 

Note: You are going to need a vcita account for this step. If you are not already registered/logged in you will need to do that.

After approving, the browser will redirect back to your app. At this point your app has exchanged the code it received to an access token which can be used to make calls to vcita. In this sample app there are several additional calls that you can make to vcita once you have the access token.

