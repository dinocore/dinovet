class ClientsController < ApplicationController

  def index
    @search = params[:search]
    @clients = Client.search(@search)
  end

  def show
    @client = Client.find(params[:id])
  end

  def new
    @client = Client.new
    @phone_numbers = @client.phone_numbers << PhoneNumber.new
  end

  def edit
    @client = Client.find(params[:id])
    @phone_numbers = @client.phone_numbers
  end

  def update
    @client = Client.find(params[:id])
    @phone_numbers = @client.phone_numbers

    if @client.update_attributes(params[:client])
      redirect_to client_path(@client), :notice => "Client updated successfully"
    else
      flash[:error] = "Failed to update client"
      render "edit"
    end
  end

  def create
    @client = Client.new(params[:client])
    @phone_numbers = @client.phone_numbers

    if @client.save
      redirect_to clients_path, :notice => "Client added successfully"
    else
      flash[:error] = "Failed to create client"
      render :new
    end
  end

end
