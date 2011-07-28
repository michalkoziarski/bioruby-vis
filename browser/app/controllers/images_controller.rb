class ImagesController < ApplicationController
  def index
    Image.reload_images
    
    @images = Image.all
  end
  
  def show
    @image = Image.find(params[:id])
  end
  
  def destroy
    @image = Image.find(params[:id])
    
    @image.perm_destroy
    
    redirect_to root_path
  end
end
