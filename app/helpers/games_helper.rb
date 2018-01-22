module GamesHelper
  def get_user_name(user)
    if user 
      return user.email
    end
    return "Guest"
  end

  def get_hidden_tag_w_user_id
    if current_user
      hidden_field_tag :user_id, current_user.id
    else
      hidden_field_tag :user_id, nil
    end
  end
end
