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
      flash[:notice] = "Client updated successfully"
      respond_to do |format|
        format.js   { redirect_to edit_client_path(@client, :format => :js) }
        format.html { redirect_to edit_client_path(@client) }
      end
    else
      flash[:error] = "Failed to update client"
      respond_to do |format|
        format.js
        format.html { render :edit }
      end
    end
  end

  def create
    @client = Client.new(params[:client])
    @phone_numbers = @client.phone_numbers

    if @client.save
      flash[:notice] = "Client added successfully"
      respond_to do |format|
        format.js   { redirect_to edit_client_path(@client, :format => :js) }
        format.html { redirect_to edit_client_path(@client) }
      end
    else
      flash[:error] = "Failed to create client"
      respond_to do |format|
        format.js
        format.html { render :new }
      end
    end
  end

end
