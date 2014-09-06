window.deviceReady = $.Deferred()
document.addEventListener 'deviceready', ->
  deviceReady.resolve()

window.addEventListener 'load', ->
  FastClick.attach(document.body)

window.Ocupado = _.extend (new Backbone.Marionette.Application()),
  env: if _ENV? then _ENV else 'development'
  config:
    clientId: '645111580333-v6ueanllqjpq9t9flu0t5gs3qagbc1pn.apps.googleusercontent.com'
    clientSecret: 'wpNU7-yyYswRprmXoS6iG7QF'
    redirectUri: 'http://localhost'
    webClientId: '645111580333-69jco4h50toqk3l2kjvuah562rml7o37.apps.googleusercontent.com'
    webApiKey: 'AIzaSyB3lhagMbhDhZnenMJ_sNZ5bdbOS7HD7kQ'
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

