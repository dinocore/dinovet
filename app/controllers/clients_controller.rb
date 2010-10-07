class ClientsController < ApplicationController

  def index
    @clients = Client.search(/.*#{params[:search]}.*/)
  end

  def show
    @client = Client.find(params[:id])
  end

  def new
    @client = Client.new
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    if @client.update_attributes(params[:client])
      redirect_to client_path(@client)
    else
      render 'edit'
    end
  end

  def create
    @client = Client.new(params[:client])
    if @client.save
      flash[:notice] = 'Client added successfully'
      redirect_to clients_path
    else
      flash[:error] = 'Failed to create client'
      render :new
    end
  end

end
