class Ocupado.Views.CalendarListView extends Backbone.Marionette.CompositeView

  template: Ocupado.Templates['app/scripts/templates/calendarList.hbs']
  itemView: Ocupado.Views.CalendarItemView
  emptyView: Ocupado.Views.CalendarEmptyView
  itemViewContainer: 'ul'
