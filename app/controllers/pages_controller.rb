class PagesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  end
  
  def show_map
    @notes = Note.all
    @note = Note.new
  end

end
