class Ocupado.Routers.AppRouter extends Backbone.Router

  routes:
    'calendar_list': 'calendarList'
    'app': 'app'

  calendarList: ->
    Ocupado.chromeRegion.close()
    Ocupado.mainRegion.show new Ocupado.Views.CalendarListView
      collection: Ocupado.calendars

  app: ->
    Ocupado.roomsView = new Ocupado.Views.RoomsView
      collection: new Ocupado.Collections.RoomsCollection
    Ocupado.mainRegion.show Ocupado.roomsView

    Ocupado.chromeView = new Ocupado.Views.ChromeView()
    Ocupado.chromeRegion.show Ocupado.chromeView

