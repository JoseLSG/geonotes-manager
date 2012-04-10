class PagesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  end
  
  def show_map
    @notes = current_user.notes
    @note = Note.new
  end

end
