class App.Collections.Todos extends Backbone.Collection

  url: '/todos'

  # Reference to this collection's model.
  model: App.Models.Todo

  # Filter down the list of all todo items that are finished.
  done: -> @filter (todo)-> todo.get 'done'

  # Filter down the list to only todo items that are still not finished.
  remaining: -> @without.apply @, @done()

  # This generates the next order number for new items.
  nextOrder: -> if !@.length then 1 else @last().get('order') + 1

  # Todos are sorted by their original insertion order.
  comparator: (todo)->
    [todo.get('done'), todo.get('order'), 1/todo.get('created_at')]

  save_order: ->
    $.ajax
      type: 'POST'
      dataType: 'JSON'
      data: @pluck ['order', 'id']
      success: (data) ->
        debugger

  fetch_by_user: (user) ->
    @fetch
      url: "/todos/user/#{user.id}"