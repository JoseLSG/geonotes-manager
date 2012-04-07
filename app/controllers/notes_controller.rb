class NotesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @notes = Note.all
  end
  
  def show
    @note = Note.find(params[:id])
    @notes = Note.all
  end
  
  def create
    @note = current_user.notes.build(params[:new_note])

    if @note.save         
      respond_to do |format|
        format.js {render @note}
      end
      
    else
      render :text => "Note creation failed"
    end
  end
  
  def edit
    @note = Note.find(params[:id])
    @notes = Note.all
  end
  
  def update
    @note = Note.find(params[:id])
    
    if @note.update_attributes(:content => params[:note][:content], :tag_list => params[:note][:tag_list])
      respond_to do |format|
        format.js {render @note}
      end
    else
      render :text => "Note update failed"
    end
     
  end
  
  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    redirect_to :controller => :pages, :action => :show_map
  end

end
