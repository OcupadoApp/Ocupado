'use strict';

class Ocupado.Views.RoomsView extends Backbone.Marionette.CollectionView

  className: 'rooms-container'
  itemView: Ocupado.Views.RoomView

  initialize: ->
    Handlebars.registerPartial('occupied', Ocupado.Templates.occupied)
    Handlebars.registerPartial('upcoming', Ocupado.Templates.upcoming)
    Handlebars.registerPartial('vacant', Ocupado.Templates.vacant)

