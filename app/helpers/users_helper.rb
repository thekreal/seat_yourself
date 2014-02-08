module UsersHelper

  def since(time, action = "joined" )
    "joined #{time_ago_in_words(time)} ago"
  end

end