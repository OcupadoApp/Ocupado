class Ocupado.Views.BookNowView extends Backbone.Marionette.ItemView
  interval: 5  # in minutes

  el: '.book-now-container'
  template: Ocupado.Templates['app/scripts/templates/bookNow.hbs']
  eventBuffer: []
  events:
    'touchstart .book-now-btn': 'handleTouchStart'
    'touchmove .book-now-btn': 'handleTouchMove'
    'touchend .book-now-btn': 'handleTouchEnd'

  onRender: ->
    @btn = @$el.find('.book-now-btn')

  handleTouchStart: (e) ->
    @btnX = @btn.offset().left + (@btn.width()/2)
    @btnY = @btn.offset().top + (@btn.height()/2)
    @touchStartX = e.originalEvent.targetTouches[0].pageX
    @touchStartY = e.originalEvent.targetTouches[0].pageY

  handleTouchMove: (e) ->
    @touchPosX = e.originalEvent.changedTouches[0].pageX
    @touchPosY = e.originalEvent.changedTouches[0].pageY

    if Ocupado.roomsView.collection.models[0]?
      arc = Ocupado.roomsView.children.findByIndex(0).roomArcView
      arcY = arc.$el.offset().top + arc.arcPosY
      arcX = arc.$el.offset().left + arc.arcPosX
      theta = Math.atan2(@touchPosY - arcY, @touchPosX - arcX)
      @newY = Math.sin(theta) * arc.maxRadius
      @newX = Math.cos(theta) * arc.maxRadius
      @updateDurationIndicator(theta)
      @btn.css
        'webkitTransform': "translate3d(#{@newX}px, #{@newY + arc.arcPosY}px, 0)"
        'transform': "translate3d(#{@newX}px, #{@newY}, 0)"

  updateDurationIndicator: (rads) ->
    degs = @toDegrees(rads)
    intervalsPassed = Math.ceil((degs / 6) / @interval)
    minutes = intervalsPassed * @interval
    @newEventDuration = new Date().addMinutes(minutes) - new Date()
    $('.room-status-text').text toReadableTime(@newEventDuration)

  toDegrees: (rads) ->
    degs = (rads * (180/Math.PI)) + 180
    degs -= 90
    degs += 360 if degs < 0
    degs

  handleTouchEnd: (e) ->
    unless $.inArray e.timeStamp, @eventBuffer
      Ocupado.roomsView.collection.models[0].bookRoom
        duration: @newEventDuration
        summary: "Room booked by Ocupado"

    @btn.css
      'webkitTransform': "translate3d(0px, 0px, 0)"
      'transform': "translate3d(0px, 0px, 0)"
    $('.room-status-text').text($('.room-status-text').data('default'))
    @eventBuffer.push e.timeStamp

