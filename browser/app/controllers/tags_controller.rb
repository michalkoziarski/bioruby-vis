class TagsController < ApplicationController
  def create
    @tag = Tag.new(params[:tag])
    
    if @tag.save
      flash[:notice] = 'Tag created'
    else
      flash[:alert] = if params[:tag][:name].blank?
        'Tag can\'t be blank'
      else
        'Tag already exist'
      end
    end
    
    redirect_to :back
  end
  
  def show
    @tag = Tag.new
    
    @images = Tag.find(params[:id]).images
    
    render 'images/index'
  end
end
