require 'spec_helper'

describe "Creating todo lists" do 
	def create_todo_list(options={})
		options[:title] ||= "My todo list" #sets a default if nothing is put
		options[:description] ||= "This is my todo list."

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"
	end 

	it "redirects to the todo list index page on success" do 
		create_todo_list

		expect(page).to have_content("My todo list")
	end

	it "displays an error when the todo list has no title" do
		expect(TodoList.count).to eq(0) #database is cleared after each test
										#so there should be no lists

		create_todo_list(title: "")

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end 

	it "displays an error when the todo list has a title < 3 characters" do
		expect(TodoList.count).to eq(0) #database is cleared after each test
										#so there should be no lists

		create_todo_list(title: "Hi")

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end 

##################### Start Description Testing ##############################

	it "displays an error when the todo list has no description" do
		expect(TodoList.count).to eq(0) #database is cleared after each test
										#so there should be no lists

		create_todo_list(title: "Grocery List",description: "")

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("Grocery List")
	end 

	it "displays an error when the todo list has a description < 5 characters" do
		expect(TodoList.count).to eq(0) #database is cleared after each test
										#so there should be no lists

		create_todo_list(title: "Grocery List", description: "food")

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end 
end