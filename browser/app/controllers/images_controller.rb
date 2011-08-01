class ImagesController < ApplicationController
  def index
    Image.reload_images
    
    @tag = Tag.new
    
    @images = if params[:image] and !params[:image][:tag].blank?
      Tag.find(params[:image][:tag]).images
    else
      Image
    end.order("file_modification_time DESC")
    
    if params[:image] and !params[:image][:query].blank?
      @images = @images.where("path LIKE ?", "%#{params[:image][:query]}%")
    end
  end
  
  def show
    @image = Image.find(params[:id])
  end
  
  def destroy
    @image = Image.find(params[:id])
    
    @image.perm_destroy
    
    redirect_to root_path
  end
  
  def tag
    @image = Image.find(params[:image_id])
    
    if @image.tag(Tag.find(params[:image][:tag]))
      flash[:notice] = "Image taged"
    else
      flash[:alert] = "Taging failed"
    end
    
    redirect_to :back
  end
end
