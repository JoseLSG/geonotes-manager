class NotesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @notes = Note.all
  end
  
  def show
    
  end
  
  def create
    geolocation = RGeo::Geographic.spherical_factory.point(params[:note][:lat], params[:note][:lon])
    @note = current_user.notes.build(:content => params[:note][:content], 
                                     :geolocation => geolocation)

    if @note.save
      respond_to do |format|
        format.js {render :note}
      end
    else
      render :text => "Note creation failed"
    end
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
