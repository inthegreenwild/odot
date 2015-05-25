class TodoItemsController < ApplicationController
  def index
  	#initialized variable "@" that gives us access to it in our view
  	@todo_list = TodoList.find(params[:todo_list_id])
  end
end
