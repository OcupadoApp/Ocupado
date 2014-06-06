window.deviceReady = $.Deferred()

document.addEventListener 'deviceready', ->
  deviceReady.resolve()

window.addEventListener 'load', ->
  FastClick.attach(document.body)

window.Ocupado = _.extend (new Backbone.Marionette.Application()),
  env: if _ENV? then _ENV else 'development'
  config:
    clientId: '65475530667-fliq4pdj73bdk1tenuq59dak5v2isic5.apps.googleusercontent.com'
    clientSecret: 'RUHUSETB3IONIzns_zGwCNVf'
    redirectUri: 'http://localhost'
    webClientId: '65475530667.apps.googleusercontent.com'
    webApiKey: 'AIzaSyDlo7Z2IJ7Ilbo0PoerU6b0dMNLEsyS-DA'
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
  # chromeRegion: '#OcupadoChrome'

if Ocupado.env is 'production'
  $ -> $.when(clientLoaded.promise(), deviceReady.promise(), calendarApiLoaded.promise(), authCompleted.promise()).then(Ocupado.init)
else
  $ -> $.when(clientLoaded.promise(), calendarApiLoaded.promise(), authCompleted.promise()).then(Ocupado.init)

