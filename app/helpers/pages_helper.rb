module PagesHelper
  
  def arinc_link(label = 'ARINC MUSE')
    link_to label, ARINC_URL, :target => '_blank'
  end
  
  def sita_link(label = 'SITA CUTE')
    link_to label, SITA_URL, :target => '_blank'
  end
  
  def resa_link(label = 'RESA CREWS')
    link_to label, RESA_URL, :target => '_blank'
  end
end
