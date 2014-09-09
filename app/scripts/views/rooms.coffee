class Ocupado.Views.RoomsView extends Backbone.Marionette.CompositeView

  template: Ocupado.Templates['app/scripts/templates/rooms.hbs']
  className: 'rooms-container'
  itemView: Ocupado.Views.RoomView
  itemViewContainer: '.room-container'
  events:
    'click .room-name': 'navigateToCalendarList'

  initialize: ->
    Handlebars.registerPartial('occupied', Ocupado.Templates.occupied)
    Handlebars.registerPartial('upcoming', Ocupado.Templates.upcoming)
    Handlebars.registerPartial('vacant', Ocupado.Templates.vacant)
    @collection.on 'update', => @render()

  onRender: ->
    $.when(Ocupado.calendars.dfdCalendarsLoaded).then =>
      if @collection.models.length
        @eventsList = new Ocupado.Views.EventsListView
          collection: @collection.models[0].get('events')
        @eventsList.render()

        if @collection.models[0].isVacant()
          @bookNowView = new Ocupado.Views.BookNowView
          @bookNowView.render()

  navigateToCalendarList: ->
    Ocupado.router.navigate 'calendar_list',
      trigger: true

