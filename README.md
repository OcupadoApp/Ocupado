# Ocupado

### About
This project was initially intended to be a simple meeting room status display to visualize which rooms were free, time remaining until the next booking, and time remaining in an occurring meeting, based off the Google Calendar API. This was designed by @luccast and developed by @gavinsmith and myself (@richgilbank).

The first version was hacked together in 2 days in CoffeeScript using [Middleman](http://middlemanapp.com/), with HTML5 Canvas for the animated polar clock/time remaining indicator. The code was hideous, non-testable and non-maintainable, so I put this version together as a Christmas hobby project.

### Stack
 - [Backbone](http://backbonejs.org/)
     - [Backbone-relational](http://backbonerelational.org/)
 - [Grunt](http://gruntjs.com/)
     - [Grunt-contrib-stylus](https://github.com/gruntjs/grunt-contrib-stylus)
     - [Grunt-contrib-handlebars](https://github.com/gruntjs/grunt-contrib-handlebars)
     - [Grunt-mocha](https://github.com/kmiyashiro/grunt-mocha)
 - [Raphael](http://raphaeljs.com/)
 - [Handlebars](http://handlebarsjs.com/)
 - [Yeoman](http://yeoman.io)
 - [Bower](http://bower.io/)

### Running it
To run it, you must have Node.js installed on your system. `cd` into the directory you cloned the repo into. From there, you'll need to install grunt and a few other things, which can be done with `npm install -g`. You'll also need to pull the bower dependencies, with `bower install`. To run the tests, you will also need to run `bower install` from the `test` directory.

`grunt server` will start the server on port 9000, from where you will have to authenticate using the Google account you use to access your meeting rooms.

`grunt test` will run the test suite (currently incomplete).

`grunt build` compiles the app into the `dist` directory.

### Screens
![Screenshot 1][1]
![Screenshot 2][2]


  [1]: http://cl.ly/image/3L072Q1W1K1z/Screen%20Shot%202013-12-29%20at%204.25.37%20PM.png
  [2]: http://cl.ly/image/0W0j200o1p3y/Screen%20Shot%202013-12-29%20at%204.25.59%20PM.png

### Roadmap
- Set up server push notifications (subscribe to Google Calendar
   changes)
  - Set up a server
  - SSL certificate required
  - Add Calendar proxy/caching service for app to pull from
- Refactor code
  - Marionette?
- Improve test coverage
- Update design (colours for Shopify version - https://github.com/richgilbank/Shopify-ocupado)
- Clean up mobile version to improve speed, reduce glitchyness with
  iScroll (some sloppy event binding in there)
- Add list of events for the day to each room (limit to 1 room per board?)
  - Update models to fetch all results from the day
  - Update styles to ensure the event list works in portrait & landscape
- Add room booking to the tablet version - just book the room
  - Requires a login for the boards to create their own event on?

