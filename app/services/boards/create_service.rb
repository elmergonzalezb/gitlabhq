module Boards
  class CreateService < BaseService
    def execute
      board = project.boards.create(params)

<<<<<<< HEAD
      if board.persisted?
        board.lists.create(list_type: :backlog)
        board.lists.create(list_type: :done)
      end
=======
    private

    def create_board!
      board = project.boards.create
      board.lists.create(list_type: :done)
>>>>>>> ce/master

      board
    end
  end
end
