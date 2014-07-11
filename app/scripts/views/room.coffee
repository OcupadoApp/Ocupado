class Ocupado.Views.RoomView extends Backbone.Marionette.ItemView

  template: Ocupado.Templates['app/scripts/templates/room.hbs']
  tagName: 'section'

  initialize: ->
    @listenTo @model, 'update', @render
    @render()
    @roomArcView = new Ocupado.Views.RoomArcView
      parentView: this
      model: @model

    setInterval =>
      if @model.status() != @previousStatus
        @render()
      else
        @partialRender()
      @previousStatus = @model.status()
    , 1000

  attributes: ->
    class: if @model.isOccupied() then 'occupied' else if @model.isUpcoming() then 'upcoming' else 'vacant'

  partialRender: ->
    @$el.find('.time-remaining').text(@timeRemaining()) unless @model.isVacant()
    @roomArcView.update()

  render: ->
    @$el.html @template(@templateData())
    @$el.attr _.extend({}, _.result(this, 'attributes'))

    @roomArcView.setup() if @roomArcView?
    @

  templateData: ->
    occupied: @model.isOccupied()
    upcoming: @model.isUpcoming()
    vacant: @model.isVacant()
    timeRemaining: do => @timeRemaining()
    name: @model.get('name')
    event: @model.get('events').sort().first().toJSON() if not @model.isVacant()

  timeRemaining: ->
    unless @model.isVacant()
      remaining = @model.get('events').sort().first().timeRemaining
      toReadableTime(remaining)
    else
      '00:00:00'

