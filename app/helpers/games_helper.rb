module GamesHelper
  def display_user_name(user)
    name = "Guest"
    if user != nil
      name = user.email
    end
    return name
  end
end
