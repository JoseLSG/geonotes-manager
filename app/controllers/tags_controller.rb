class TagsController < ApplicationController
  
  def show
    @tag = Tag.includes(:notes).find(params[:id])
    @notes = @tag.notes
    # @note = Note.new
    
    render "pages/show_map"
  end
  
end
