class NotesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @notes = Note.all
  end
  
  def show
    
  end
  
  def create
    geolocation = RGeo::Geographic.spherical_factory.point(params[:new_note][:lon], params[:new_note][:lat])
    @note = current_user.notes.build(:content => params[:new_note][:content], :geolocation => geolocation)

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
    
    if @note.update_attributes(:content => params[:note][:content])
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
