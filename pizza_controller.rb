require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative('./models/pizza.rb')

# REST 
# INDEX = READ - all
get '/pizzas' do
  @pizzas = Pizza.all()
  erb(:index)
end

# NEW = CREATE - get form
# This needs to appear before the 'SHOW' route otherwise 'new' will match the pizzas/:id pattern and fail on trying to find a pizza with index No ='new'
get '/pizzas/new' do
  #  return "Hit NEW route"  # demo line before adding code
  erb (:new )   # now go define new.erb in views/ folder
end

# SHOW = READ - find by ID
get "/pizzas/:id" do
  @pizza = Pizza.find(params[:id])
  erb( :show )
end


# CREATE = CREATE - submit form
post "/pizzas" do
  @pizza = Pizza.new(params)
  @pizza.save
  # erb( :show )  - easy option re-using SHOW baove
  erb(:create)  # use special confirmation page
end

# EDIT - UPDATE - create form
get "/pizzas/:id/edit" do
  @pizza = Pizza.find(params[:id])
  erb(:edit)
end

# UPDATE - UPDATE - submit form
post "/pizzas/:id" do
  pizza = Pizza.new(params)
  pizza.update
  redirect to "/pizzas/#{pizza.id}"
end


# DESTROY - DELETE
post "/pizzas/:id/delete" do
  @pizza = Pizza.find(params[:id])
  @pizza.delete
  redirect to "/deleted/#{params[:id].to_s}"
end
get "/deleted/:id" do
  erb(:deleted)
end
