# Social Login Creation

This gem contains the Twitter,Facebook,Linked-In strategy for OmniAuth.

Twitter offers a few different methods of integration. This strategy implements the browser variant of the "[Sign in with Twitter](https://dev.twitter.com/docs/auth/implementing-sign-twitter)" flow.

Twitter uses OAuth 1.0a. Twitter developer area contains sample documentation on how it implements this, so if you are really interested in the details, go check that out for more.

Facebook offers a few different methods of integration. This strategy implements the browser variant of the "[Sign in with Facebook](https://developers.facebook.com/docs/facebook-login/getting-started-web/)" flow.

Facebook uses OAuth 1.0a. Facebook developer area contains sample documentation on how it implements this, so if you are really interested in the details, go check that out for more.

LinkedIn offers a few different methods of integration. This strategy implements the browser variant of the "[Sign in with LinkedIn](https://developer.linkedin.com/documents/authentication)" flow.

LinkedIn uses OAuth 1.0a. LinkedIn developer area contains sample documentation on how it implements this, so if you are really interested in the details, go check that out for more.


## Before You Begin

We will insert some lines of code in your files 'app/controllers/application_controller.rb'.

Now sign in into the Twitter developer area(https://dev.twitter.com) and create an application. Take note of your Consumer Key and Consumer Secret (not the Access Token and Secret) because that is what your web application will use to authenticate against the Twitter API. Make sure to set a callback URL or else you may get authentication errors. (It doesn't matter what it is, just that it is set.)

Now sign in into the Facebook developer area(https://developers.facebook.com/) and create an application. Take note of your Consumer Key and Consumer Secret (not the Access Token and Secret) because that is what your web application will use to authenticate against the Facbook API. Make sure to set a callback URL or else you may get authentication errors. (It doesn't matter what it is, just that it is set.)

Now sign in into the LinkedIn developer area(https://developer.linkedin.com/) and create an application. Take note of your Consumer Key and Consumer Secret (not the Access Token and Secret) because that is what your web application will use to authenticate against the LinkedIn API. Make sure to set a callback URL or else you may get authentication errors. (It doesn't matter what it is, just that it is set.)

## Install Using This Strategy

First start by adding this gem to your Gemfile:

```ruby
gem 'social_login' , '0.0.1'
```
Then just do a 'bundle update'.

```console
bundle update
```

After that run the command  'rails g social_login' in your terminal editor.

```console
rails g social_login
```

If you have already installed devise for user, the generator will skip the steps for installation of devise.

If the file 'config/application.rb' doesnt have the line 

```console
"config.devise_model_name ='user'" 
```

Please insert before the end keyword of the class Application, where the devise model name(user/employee/post) what you are using should be specified appropriately.

Replace the 'consumer_key' and 'consumer_secret' in the respective provider (twitter,facebook,linkedin).yml files in your config folder.

Place the code to get current user signed in your default index file.

```console
<% if current_user %>
   Logged in as <strong><%= current_user.email %></strong>.
   <%= link_to "Sign Out", signout_path,:class => 'navbar-link' %>
<%end%>
```
Place the style in your application.css file:

```console
.notice
{
	padding:5px;
	font-weight: bold;
}
```

This project rocks and uses "[MIT-LICENSE](https://github.com/VelanApps/SocialLogin/blob/master/MIT-LICENSE)".