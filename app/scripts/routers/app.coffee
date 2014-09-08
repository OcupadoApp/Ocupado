class Ocupado.Routers.AppRouter extends Backbone.Router

  routes:
    'calendar_list': 'calendarList'
    'app': 'app'

  calendarList: ->
    Ocupado.mainRegion.show new Ocupado.Views.CalendarListView
      collection: Ocupado.calendars

  app: ->
    if Ocupado.roomsView?
      Ocupado.roomsView.collection.initCalendarResources()
    else
      Ocupado.roomsView = new Ocupado.Views.RoomsView
        collection: new Ocupado.Collections.RoomsCollection
    Ocupado.mainRegion.show Ocupado.roomsView
    Ocupado.roomsView.delegateEvents()

