require 'spec_helper'

describe TodoItem do
  it { should belong_to(:todo_list)} #using should belong_to feature from 
  									 #shoulda-matchers gem 
end
