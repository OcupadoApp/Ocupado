window.deviceReady = $.Deferred()
document.addEventListener 'deviceready', ->
  deviceReady.resolve()

window.addEventListener 'load', ->
  FastClick.attach(document.body)

window.Ocupado = _.extend (new Backbone.Marionette.Application()),
  env: if _ENV? then _ENV else 'development'
  config:
    clientId: '130023180090-hm7chbbqpr84hhg42r77jgaivuvuh2ns.apps.googleusercontent.com'
    clientSecret: 'wyM_IJHbmvPuLitGJ-nb-v6T'
    redirectUri: 'http://localhost'
    webClientId: '130023180090-9mes73f8vancio9ocm8dh6l8ji82v1ed.apps.googleusercontent.com'
    webApiKey: 'AIzaSyDc-dRIAd0rPnZK4MwuExeBG_JBcnWyTRE'
    scope: 'https://www.googleapis.com/auth/calendar'

  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    Ocupado.calendars = new Ocupado.Collections.CalendarCollection()
    Ocupado.router = new Ocupado.Routers.AppRouter()
    Backbone.history.start()
    if Ocupado.calendars.getSelectedResources().length
      Ocupado.router.navigate 'app',
        trigger: true
    else
      Ocupado.router.navigate 'calendar_list',
        trigger: true

, Backbone.Events

Ocupado.addRegions
  mainRegion: '#OcupadoApp'

if Ocupado.env is 'production'
  $ -> $.when(clientLoaded.promise(), deviceReady.promise(), calendarApiLoaded.promise(), authCompleted.promise()).then(Ocupado.init)
else
  $ -> $.when(clientLoaded.promise(), calendarApiLoaded.promise(), authCompleted.promise()).then(Ocupado.init)

