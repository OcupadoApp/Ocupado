class Ocupado.Views.CalendarItemView extends Backbone.Marionette.ItemView

  tagName: 'li'
  template: Ocupado.Templates['app/scripts/templates/calendarItem.hbs']
  events:
    'click': 'onRoomSelection'

  onRoomSelection: (e) =>
    e.preventDefault()
    Ocupado.calendars.setSelectedResources [@model.get('resourceId')]
    Ocupado.router.navigate 'app',
      trigger: true
