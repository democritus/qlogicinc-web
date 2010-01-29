# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Automatically include LabellingFormBuilder into form_for block
  def labelled_form_for(record_or_name_or_array, *args, &proc)
    options = args.extract_options!
    form_for(record_or_name_or_array,
      *(args << options.merge(:builder => LabellingFormBuilder)), &proc)
  end
  
  def random_quote
    quotes = [
      {
        'text' => t(:quote_1),
        'author' => t(:quote_1_author)
      },
      {
        'text' => t(:quote_2),
        'author' => t(:quote_2_author)
      },
      {
        'text' => t(:quote_3),
        'author' => t(:quote_3_author)
      },
      {
        'text' => t(:quote_4),
        'author' => t(:quote_4_author)
      },
      {
        'text' => t(:quote_5),
        'author' => t(:quote_5_author)
      },
      {
        'text' => t(:quote_6),
        'author' => t(:quote_6_author)
      },
      {
        'text' => t(:quote_7),
        'author' => t(:quote_7_author)
      },
      {
        'text' => t(:quote_8),
        'author' => t(:quote_8_author)
      }
    ]
    quote = quotes[rand(quotes.length)]
    "\"#{quote['text']}\"<div class=\"author\">–#{quote['author']}</div>" 
  end
end

def random_fact
  facts = [
    t(:fact_1),
    t(:fact_2),
    t(:fact_3),
    t(:fact_4),
    t(:fact_5),
    t(:fact_6),
    t(:fact_7),
    t(:fact_8),
    t(:fact_9),
    t(:fact_10),
    t(:fact_11),
    t(:fact_12),
    t(:fact_13),
    t(:fact_14)
  ]
  return facts[rand(facts.length)]
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
