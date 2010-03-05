module RoundedBoxHelper

  def rounded_box(content)
    %Q{
      <div class="rounded_box_t">
      <div class="rounded_box_l">
      <div class="rounded_box_r">
      <div class="rounded_box_b">
      <div class="rounded_box_tl">
      <div class="rounded_box_tr">
      <div class="rounded_box_bl">
      <div class="rounded_box_br">
      <div class="rounded_box clearfix">
      #{content}
      </div></div></div></div></div></div></div></div></div> 
    }
  end
  
  def featured_item_box( header, text, image_path, url, image_options = {} )
    rounded_box(%Q{
      <h3>#{link_to header, url}</h3>
      <div class="image">
        #{link_to(
          image_tag(image_path, image_options),
          url)}
      </div>
      <p>
        #{link_to text, url}
      </p>
    })
  end
end
