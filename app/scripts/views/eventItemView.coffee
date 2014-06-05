'use strict';

class Ocupado.Views.EventItemView extends Backbone.Marionette.ItemView
  tagName: 'li'
  template: Ocupado.Templates['app/scripts/templates/eventItem.hbs']

  events:
    'click': 'toggleDetail'

  toggleDetail: ->
    @$el.toggleClass('open')

