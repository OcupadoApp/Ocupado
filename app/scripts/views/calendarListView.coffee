class Ocupado.Views.CalendarListView extends Backbone.Marionette.CompositeView

  template: Ocupado.Templates['app/scripts/templates/calendarList.hbs']
  itemView: Ocupado.Views.CalendarItemView
  emptyView: Ocupado.Views.CalendarEmptyView
  itemViewContainer: 'ul'
  events:
    'click .sign-out': 'onSignoutClick'

  onSignoutClick: (e) ->
    e.preventDefault()
    Ocupado.Auth.signOut()
