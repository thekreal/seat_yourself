module ApplicationHelper

  SITE_NAME = "SEAT UR SELF"

  def titler(page_title)
    page_title.empty? ? site_name : "#{site_name} | #{page_title}"
  end

  def site_name
    return SITE_NAME
  end

end
