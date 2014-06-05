'use strict';

class Ocupado.Views.CalendarSelectionModalView extends Backbone.View

  template: Ocupado.Templates['app/scripts/templates/calendarSelectionModal.hbs']

  events:
    'change input[type="radio"]': 'onRadioChange'
    'click .close-modal': 'close'

  initialize: ->
    @render()
    @animateModalEntering()

  render: ->
    @$el.html @template({cals:Ocupado.calendars.toJSON()})

    @overlay = @$el.find('.modal-overlay')
    @modal = @$el.find('.modal')

    @

  animateModalEntering: ->
    setTimeout =>
      @overlay.addClass 'active'
      setTimeout =>
        @modal.addClass 'active'
      , 300
    , 10

  close: =>
    @modal.removeClass 'active'
    @modal.one 'webkitTransitionEnd transitionend', =>
      @overlay.removeClass 'active'
      @overlay.one 'webkitTransitionEnd transitionend', =>
        @parentView.modal = null
        @remove()
        @unbind()

  onRadioChange: (e) =>
    resourceId = @$el.find('input[name="calendarId"]:checked').val()

    Ocupado.calendars.setSelectedResources [resourceId]
    Ocupado.roomsView.collection.reset()
    Ocupado.roomsView.collection.setupModels()

