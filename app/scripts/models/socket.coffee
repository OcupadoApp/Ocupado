'use strict'

class Ocupado.Models.Socket extends Backbone.Model
  defaults:
    deviceId: deviceId()

  initialize: ->
    Ocupado.calendars.dfdCalendarsLoaded.then =>
      @socket = io('http://ocupadoapp.com:1337')
      @socket.on 'handshake:request', @onHandshakeResponse
      @socket.on 'sync', @onSync

  onHandshakeResponse: =>
    @socket.emit 'handshake:response',
      id: @get('deviceId')

  onSync: =>
    Ocupado.fetch()
