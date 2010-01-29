class PagesController < ApplicationController

  caches_page :show
  
  def index
    @pages = Page.all
  end
  
  def show
    if params[:permalink]
      @page = Page.find_by_permalink(params[:permalink])
      
      source = 'file' # file or database
      if source == 'file'
        filename = RAILS_ROOT + '/app/views/pages/source/_' +
          params[:permalink] + '.html.erb'
        f = File.new(filename)
        if File.exists?(filename)
          render :partial => 'pages/source/' + params[:permalink],
            :layout => true
        else
          from_database = ''
          if @page
            from_database = '<p>Copy the following HTML to ' + filename + ':' +
              '<br /><textarea cols="60" rows="8">' +
              CGI.escapeHTML(@page.content) + '</textarea>'
          end
          render :text => 'Semi-static page doesn\'t exist.' + from_database
        end
      end
    else
      @page = Page.find(params[:id])
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
