class Ocupado.Views.CalendarItemView extends Backbone.Marionette.ItemView

  tagName: 'li'
  isEmpty: false
  events:
    'click a': 'onRoomSelection'

  getTemplate: ->
    if @isEmpty || @options.isEmpty
      Ocupado.Templates['app/scripts/templates/calendarEmpty.hbs']
    else
      Ocupado.Templates['app/scripts/templates/calendarItem.hbs']

  onRoomSelection: (e) ->
    e.preventDefault()
    Ocupado.calendars.setSelectedResources [@$el.find('a').data('id')]
    Ocupado.router.navigate 'app'

