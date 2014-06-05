class Ocupado.Views.ChromeView extends Backbone.View

  template: Ocupado.Templates['app/scripts/templates/chrome.hbs']
  events:
    'click #calendarSelectionBtn': 'navigateToCalendarList'

  initialize: ->
    @render()
    $.when(Ocupado.calendars.dfdCalendarsLoaded).then =>
      @$el.show()
      @$el.on 'click', '#calendarMenuBtn', @onMenuClick
      @eventsList = new Ocupado.Views.EventsListView
        collection: Ocupado.roomsView.collection.models[0].get('events')
      @eventsList.render()

  render: ->
    @$el.html @template()

  onMenuClick: (e) =>
    e.preventDefault()
    if !@modal?
      @modal = new Ocupado.Views.CalendarSelectionModalView()
      @modal.parentView = this
      @$el.append @modal.el
    else
      @modal.close()

  navigateToCalendarList: ->
    Ocupado.router.navigate 'calendar_list',
      trigger: true

