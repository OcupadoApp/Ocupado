'use strict';

ARC_DATA =
  vacant:
    bgStroke: 1
    arcStroke: 1
    bgColor: '#0a3d33'
  upcoming:
    bgStrokeWidth: 1
    arcStrokeWidth: 1
    bgColor: '#96bf48'
  occupied:
    bgStrokeWidth: 1
    arcStrokeWidth: 5
    bgColor: '#cccccc'
    arcColor: '#0f8e8e'

class Ocupado.Views.RoomArcView extends Backbone.View

  setup: ->
    @el = @options.parentView.$el.find('.polar-clock').get(0)
    @$el = $(@el)

    @maxRadius = _.min([@$el.width(), @$el.height()]) / 2 - 10
    @arcPosX = @$el.width() / 2
    @arcPosY = @maxRadius + 8

    @paper = Raphael(@el, @$el.width(), @$el.height())
    @paper.customAttributes.arc = RaphaelArc

    # Background circle
    status = @model.status()
    @bgarc = @paper.path().attr
      "stroke": ARC_DATA[status].bgColor
      "stroke-width": ARC_DATA[status].bgStrokeWidth
      arc: [@arcPosX, @arcPosY, 100, 100, @maxRadius]

    @arc = @paper.path().attr
      "stroke": ARC_DATA[status].arcColor
      "stroke-width": ARC_DATA[status].arcStrokeWidth
      arc: [@arcPosX, @arcPosY, 0, 100, @maxRadius]

  update: ->
    @arc.animate
      arc: [@arcPosX, @arcPosY, @model.percentComplete(), 100, @maxRadius]
    , 1000, 'linear'
