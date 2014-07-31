'use strict';

ARC_DATA =
  vacant:
    arcStrokeWidth: 1
    bgColor: '#0a3d33'
    arcColor: '#0d7f7f'
  upcoming:
    arcStrokeWidth: 1
    bgColor: '#ffffff'
  occupied:
    arcStrokeWidth: 3
    bgColor: '#ffffff'
    arcColor: '#ffffff'

class Ocupado.Views.RoomArcView extends Backbone.View

  initialize: ->
    Ocupado.roomArcView = @

  setup: ->
    status = @model.status()
    @el = @options.parentView.$el.find('.polar-clock').get(0)
    @$el = $(@el)

    maxWidth = Math.max.call(null, ARC_DATA[status].arcStrokeWidth)
    @maxRadius = _.min([@$el.width(), @$el.height()]) / 2 - maxWidth

    @arcPosX = @$el.width() / 2
    @arcPosY = @maxRadius + maxWidth

    @paper = Raphael(@el, @$el.width(), @$el.height())
    @paper.customAttributes.arc = RaphaelArc

    # Background circle (dots)
    @bgarc = @paper.path().attr
      "stroke": ARC_DATA[status].bgColor
      "stroke-width": 2
      "stroke-dasharray": '. '
      arc: [@arcPosX, @arcPosY, 100, 100, @maxRadius]
    $(@bgarc.node).attr('stroke-dasharray', "1, 16")

    @arc = @paper.path().attr
      "stroke": ARC_DATA[status].arcColor
      "stroke-width": ARC_DATA[status].arcStrokeWidth
      arc: [@arcPosX, @arcPosY, 0, 100, @maxRadius]

  update: ->
    @arc.animate
      arc: [@arcPosX, @arcPosY, @model.percentComplete(), 100, @maxRadius]
    , 1000, 'linear'
