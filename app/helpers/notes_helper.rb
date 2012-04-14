module NotesHelper
  def tag_links(tags)
    html = ""
    tags.each do |tag|
      html += link_to tag.name, tag, :"data-ajax" => :false, :class => :tag
      html += " " unless tag == tags.last
    end
    raw html
  end
  
  def regional_info(note)
    region_info = [note.region.country, note.region.state] unless note.region.nil?
    local_info = [note.local.city] unless note.local.nil?
    list_info(region_info, local_info)
  end
  
  def location_info(note)
    region_info = [note.region.continent, note.region.country, note.region.state] unless note.region.nil?
    local_info = [note.local.city,       note.local.borough,  note.local.street] unless note.local.nil?
    list_info(region_info, local_info)
  end
  
  def list_info(region_info=[], local_info=[])  
    text = (region_info || []) + (local_info || [])
    text.compact!
    text.join ", "
  end
  
end
