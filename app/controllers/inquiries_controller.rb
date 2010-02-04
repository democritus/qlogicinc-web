class InquiriesController < ApplicationController

  caches_page :new
  
  def index
    @inquiries = Inquiry.all
  end
  
  def show
    @inquiry = Inquiry.find(params[:id])
  end
  
  #def new
  #  @inquiry = Inquiry.new
  #end
  
  def create
    @inquiry = Inquiry.new(params[:inquiry])
    if @inquiry.save
      flash[:notice] = t(:inquiry_created_confirmation)
    else
      # Save data in session since we're going to redirect
      session[:inquiry] = @inquiry
    end
    redirect_to url_for('/contact') # Contact form located on static page
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
