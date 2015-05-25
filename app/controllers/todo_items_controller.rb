class TodoItemsController < ApplicationController
  def index
  	#initialized variable "@" that gives us access to it in our view
  	@todo_list = TodoList.find(params[:todo_list_id])
  end

  def new 
  	@todo_list = TodoList.find(params[:todo_list_id])
  	@todo_item = @todo_list.todo_items.new
  end 

  def create
  	@todo_list = TodoList.find(params[:todo_list_id])
  	@todo_item = @todo_list.todo_items.new(todo_items_params)

  	if @todo_item.save 
  		flash[:success] = "Added todo list item."
  		redirect_to todo_list_todo_items_path 
  	else 
  		flash[:error] = "There was a problem adding that todo liste item"
  		render action: :new 
  	end 
  end 

  private 
  def todo_items_params
  	params[:todo_item].permit(:content)
  end 
end
