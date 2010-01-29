module InquiriesHelper
  
  def from_name
    unless @inquiry['name'].blank? && @inquiry['email'].blank?
      unless @inquiry['name'].blank?
        @inquiry['name']
      else
        @inquiry['email']
      end
    else
      'anonymous'
    end
  end
end
