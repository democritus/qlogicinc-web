class InquiriesController < ApplicationController
  def index
    @inquiries = Inquiry.all
  end
  
  def show
    @inquiry = Inquiry.find(params[:id])
  end
  
  def new
    @inquiry = Inquiry.new
  end
  
  def create
    @inquiry = Inquiry.new(params[:inquiry])
    if @inquiry.save
      flash[:notice] = t(:inquiry_created_confirmation)
      redirect_to contact_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @inquiry = Inquiry.find(params[:id])
  end
  
  def update
    @inquiry = Inquiry.find(params[:id])
    if @inquiry.update_attributes(params[:inquiry])
      flash[:notice] = t(:inquiry_updated_confirmation)
      redirect_to @inquiry
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @inquiry = Inquiry.find(params[:id])
    @inquiry.destroy
    flash[:notice] = t(:inquiry_destroyed_confirmation)
    redirect_to inquiries_url
  end
end
