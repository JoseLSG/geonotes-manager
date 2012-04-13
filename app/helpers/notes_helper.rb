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
    "#{note.region.country}, #{note.region.state}, #{note.local.city}" unless note.region.nil?
  end
end
