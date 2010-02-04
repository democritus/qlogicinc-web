# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def website_author_link_tag(email)
    tag :link, { :href => 'mailto:' + email, :rev => 'made' }
  end
  
  def alternate_languages_link_tag
    html = ''
    I18n.available_locales.each do |locale|
      next if I18n.locale == locale
      html += tag(:link,
        {
          :rel => 'alternate',
          :href => url_for(:subdomain => locale, :only_path => false),
          :hreflang => locale,
          :title => t(locale) + ' translation'
        }
      ) + "\n"
    end
    return html
  end
  
  # Automatically include LabellingFormBuilder into form_for block
  def labelled_form_for(record_or_name_or_array, *args, &proc)
    options = args.extract_options!
    form_for(record_or_name_or_array,
      *(args << options.merge(:builder => LabellingFormBuilder)), &proc)
  end
  
  def random_quote
    quotes = []
    (1..QUOTE_COUNT).each do |i|
      quotes << {
        :text => t("quote_#{i}".to_sym),
        :author => t("quote_#{i}_author".to_sym)
      }
    end
    return quotes[rand(quotes.length)]
  end
  
  def random_quote_html
    open_tag = ''
    close_tag = ''
    if @page_caching_active
      open_tag = '<NOSCRIPT>'
      close_tag = '</NOSCRIPT>'
    end
    quote = random_quote
    html = ''
    suffix = prefix = '"'
    [:text, :author].each do |type|    
      if type == :author 
        prefix = '– '
        suffix = ''
      end
      html += "<div id=\"quote_#{type.to_s}\" class=\"#{type.to_s}\">" +
        open_tag + prefix + quote[type] + suffix + close_tag + '</div>'
    end
    return html
  end
  
  def random_fact
    facts = []
    (1..FACT_COUNT).each do |i|
      facts << t("fact_#{i}".to_sym)
    end
    return facts[rand(facts.length)]
  end
  
  def random_fact_html
    open_tag = ''
    close_tag = ''
    if @page_caching_active
      open_tag = '<NOSCRIPT>'
      close_tag = '</NOSCRIPT>'
    end
    html = ''
    html += "<div id=\"factoid_text\">" + open_tag + random_fact +
      close_tag + '</div>'
    return html
  end
end

# Customize FormBuilder's output
class LabellingFormBuilder < ActionView::Helpers::FormBuilder
  
  def check_box(attribute, options={})
    super + apply_label(attribute, options)
  end
  
  def date_select(attribute, options={})
    apply_label(attribute, options) + super
  end
  
  def datetime_select(attribute, options={})
    apply_label(attribute, options) + super
  end
  
  #def radio_button(attribute, tag_value, options={})
  #  super + apply_label(attribute, options)
  #end
  
  def radio_buttons_from_list(attribute, choices, options={})
    choices.each_with_index do |choice, i|
      result += radio_button(attribute, choice[1], { :label_text => choice[0] })
    end
    return result || ''
  end
  
  def select(attribute, choices, options={}, html_options={})
    apply_label(attribute, options) + super
  end
  
  def text_area(attribute, options={})
    # Change default number of rows
    if options[:rows].blank?
      options[:rows] = 6
    end
    apply_label(attribute, options) + super
  end
  
  def text_field(attribute, options={})
    apply_label(attribute, options) + super
  end
  
  
  private
  
  # Apply label to field
  def apply_label(attribute, options={})
    label_text = nil
    # Allow custom label_text to be passed in field's options hash
    if options.include?(:label_text)
      label_text = options[:label_text]
    end
    label(attribute, label_text)
  end
  
  #def apply_radio_label(attribute, value) 
    #label(attribute, label_text)
    #value.to_s
    #label_tag(modelname_attributename_tagvalue, tagvalue)
    #classify.constantize
  #end
    
end
