class PagesController < ApplicationController
  
  caches_page :show
  
  def index
    @pages = Page.all
  end
  
  def show
    if params[:permalink]
      @page = Page.find_by_permalink(params[:permalink])
    else
      @page = Page.find(params[:id])
    end
    # Use layout with contact form for contact page
    if params[:permalink] == 'contact'    
      if session[:inquiry] # Load data from session after redirect
        @inquiry = session[:inquiry]
        session[:inquiry] = nil
      else
        @inquiry = Inquiry.new
      end
      render :layout => 'pages_contact'
    end
  end
  
  def new
    @page = Page.new
  end
  
  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = t(:page_created_confirmation)
      redirect_to @page
    else
      flash.merge!(session[:flash]) unless session[:flash].blank?
      render :action => 'new'
    end
  end
  
  def edit
    @page = Page.find(params[:id])
  end
  
  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      flash[:notice] = t(:page_updated_confirmation)
      redirect_to @page
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = t(:page_destroyed_confirmation)
    redirect_to pages_url
  end
end
