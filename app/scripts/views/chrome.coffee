'use strict';

class Ocupado.Views.ChromeView extends Backbone.View

  el: '#OcupadoChrome'
  template: Ocupado.Templates['app/scripts/templates/chrome.hbs']

  initialize: ->
    @render()
    $.when(Ocupado.calendars.dfdCalendarsLoaded).then =>
      @$el.show()
      @$el.on 'click', '#calendarMenuBtn', @onMenuClick
      @eventsList = new Ocupado.Views.EventsListView()

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

