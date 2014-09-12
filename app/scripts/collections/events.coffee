'use strict';

class Ocupado.Collections.EventsCollection extends Backbone.Collection
  model: Ocupado.Models.EventModel

  initialize: ->
    setTimeout @setupEventWatch

  comparator: 'startDate'

  isOccupied: ->
    !!@whereOccupied().length

  isUpcoming: ->
    !!@whereUpcoming().length

  isVacant: ->
    !@isOccupied() and !@isUpcoming()

  whereOccupied: ->
    @filter (event) -> event.isOccurring()

  whereUpcoming: ->
    @filter (event) -> event.isUpcoming()

  setupEventWatch: =>
    deviceId = Ocupado.socket.get('deviceId')
    calendarId = @room.get('calendarId')
    request = gapi.client.calendar.events.watch
      calendarId: calendarId
      resource:
        id: deviceId
        token: deviceId
        type: 'web_hook'
        address: 'https://ocupadoapp.com/updates/reload_calendar'
    request.execute(->)
