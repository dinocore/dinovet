class ClientsController < ApplicationController

  def index
  end

  def new
    @client = Client.new
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
