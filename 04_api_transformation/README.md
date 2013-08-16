API Transformation Code Challenge
========================

Your challenge, should you accept it, is to create a script that consumes an API and transforms it into something more useful. This is something we do all the time, especially for those in the middle-end JSMVC camp. Taking an XML feed and turning it into JSON is of particular interest, but taking a poorly formatted JSON feed and turning it into something Angular can handle is very helpful.

Bonus points will be awarded to:

* Most elegant and readable solution
* Best named project
* Best test suite
* People who actually present their solutions :)

## Stage 1

* Create a class that consumes the XML feed from the [NYT Congressional API](http://developer.nytimes.com/docs/congress_api) and stores the parsed xml object in an instance variable.
* In particular, obtain a list of all the most recent bills, their title, and their most recent major action.
* Make a method that returns a json object with just those three items.

## Stage 2

Do one of the following:

* Take that response and serve it from Sinatra.
* Wrap the class in a gem and make it available for others to use via Sinatra.