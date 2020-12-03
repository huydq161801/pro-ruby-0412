module ApplicationHelper
  def avatar_url user
    return user.image if user.image
    "https://static.yeah1.com/uploads/editors/27/2020/03/21/JaZBMzV14fzRI4vBWG8jymplSUGSGgimkqtJakOV.jpeg"
  end
end
