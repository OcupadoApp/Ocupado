class Ocupado.Routers.AppRouter extends Backbone.Router

  routes:
    'calendar_list': 'calendarList'
    'app': 'app'

  calendarList: ->
    Ocupado.chromeView.$el.addClass('clickThrough').hide() if Ocupado.chromeView?
    Ocupado.mainRegion.show new Ocupado.Views.CalendarListView
      collection: Ocupado.calendars

  app: ->
    unless Ocupado.roomsView?
      Ocupado.roomsView = new Ocupado.Views.RoomsView
        collection: new Ocupado.Collections.RoomsCollection
    Ocupado.mainRegion.show Ocupado.roomsView

    Ocupado.chromeView = new Ocupado.Views.ChromeView() unless Ocupado.chromeView?
    Ocupado.chromeView.$el.removeClass('clickThrough').show()

