'use strict';

class Ocupado.Collections.RoomsCollection extends Backbone.Collection
  model: Ocupado.Models.RoomModel

  initialize: (models, options) ->
    @initCalendarResources() unless options?.unAuthenticated
    Ocupado.fetch = => @fetchAll()

  comparator: (model) ->
    Ocupado.calendars.getSelectedResources().indexOf model.get('calendarId')

  initCalendarResources: ->
    $.when(Ocupado.calendars.dfdCalendarsLoaded.promise()).then =>
      @setupModels()

  setupModels: ->
    @reset
      calendarId: Ocupado.calendars.getSelectedCalendars()[0].get('resourceId')
    @fetchAll()

  fetchAll: ->
    @trigger 'fetchAll'

