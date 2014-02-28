'use strict';

class Ocupado.Views.EventsListView extends Backbone.View

  el: '#eventsListContainer'
  template: Ocupado.Templates['app/scripts/templates/eventsList.hbs']

  events:
    'touchstart .events-list-handle': 'handleTouchStart'
    'touchmove .events-list-handle': 'handleTouchMove'
    'touchend .events-list-handle': 'handleTouchEnd'

  initialize: ->
    @render()
    @startingPositionX = 0

    @listenTo Ocupado.roomsView.collection, 'add', @render
    @listenTo Ocupado.roomsView.collection, 'remove', @render

    @listenTo Ocupado.roomsView.collection.models[0].get('events'), 'add', @render
    @listenTo Ocupado.roomsView.collection.models[0].get('events'), 'remove', @render

    @$el.on 'click', 'li', @openDetail

  render: ->
    if Ocupado.roomsView.collection.length != 1
      @$el.html ''
      return false
    events = Ocupado.roomsView.collection.models[0].get('events').toJSON()
    @$el.html @template
      events: events
    @eventsListEl = @$el.find '.events-list'

  handleTouchStart: (e) ->
    @touchStartX = e.originalEvent.targetTouches[0].pageX
    @eventsListEl.css
      '-webkit-transition': "none"
      'transition': "none"

  handleTouchMove: (e) ->
    @touchDeltaX = e.originalEvent.changedTouches[0].pageX - @touchStartX
    if Math.abs(@startingPositionX + @touchDeltaX) < @eventsListEl.outerWidth(true)
      @eventsListEl.css
        '-webkit-transform': "translate3d(#{@startingPositionX + @touchDeltaX}px, 0, 0)"
        'transform': "translate3d(#{@startingPositionX + @touchDeltaX}px, 0, 0)"

  handleTouchEnd: (e) ->
    if Math.abs(@touchDeltaX) > @eventsListEl.outerWidth(true)/3 && @touchDeltaX < 0
      moveTo = "-#{@eventsListEl.outerWidth(true)}px"
      @startingPositionX = @eventsListEl.outerWidth(true) * -1
    else
      moveTo = "0"
      @startingPositionX = 0
    @eventsListEl.css
      '-webkit-transition': "all 0.4s ease-out"
      'transition': "all 0.4s ease-out"
    @eventsListEl.css
      '-webkit-transform': "translate3d(#{moveTo}, 0, 0)"
      'transform': "translate3d(#{moveTo}, 0, 0)"

  openDetail: ->
    $(@).toggleClass('open')

