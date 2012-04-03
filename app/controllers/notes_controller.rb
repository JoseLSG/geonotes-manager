class NotesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @notes = Note.all
  end
  
  def edit
    @note = Note.find(params[:id])
  end
  
  def update
    @note = Note.find(params[:id])
    if @note.update_attributes(params[:note])
      redirect_to notes_path
    else
      render :edit
    end
     
  end

end
