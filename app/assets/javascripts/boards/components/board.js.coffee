Board = Vue.extend
  props:
    board: Object
  data: ->
    dragging: BoardsStore.dragging
  methods:
    clearSearch: ->
      this.query = ''
  computed:
    isPreset: ->
      typeof this.board.id != 'number'
  ready: ->
    Sortable.create this.$el.parentNode,
      group: 'boards'
      animation: 150
      draggable: '.is-draggable'
      forceFallback: true
      fallbackClass: 'is-dragging'
      ghostClass: 'is-ghost'
      onUpdate: (e) ->
        BoardsStore.moveBoard(e.oldIndex + 1, e.newIndex + 1)

Vue.component('board', Board)
