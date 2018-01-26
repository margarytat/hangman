module GamesHelper
  def get_user_name(user)
    if user
      return user.email
    end
    return "Guest"
  end

  def get_hidden_tag_w_user_id
    uid = nil
    if current_user
      uid = current_user.id
    end
    hidden_field_tag :user_id, uid
  end

  def get_word_chars_display
    content_tag :table, class: "table-bordered page-content" do
      content_tag :tbody do
        content_tag :tr do
          @game.word.each_char do |c|
            lbl = "_"
            if (c.to_s.match /[^a-zA-Z]/ ) || (@game.current_guesses.include? c.to_s.downcase)
              lbl = c.to_s
            end
            concat (content_tag :td, lbl, class: "word-letter")
          end # each char
        end # tr
      end # tbody
    end # table
  end

  def get_hangman_image(num)
    if num < Game.MAX_NUM_WRONG_GUESSES
      image_tag asset_path("h_#{num}.png"), class: "img-responsive center-block"
    end
  end

  def get_game_over_banner
    if @game.user_won != nil
      extra_class = "user-lost-banner"
      caption = "You lost! The word was \"#{@game.word}\"."
      if @game.user_won == true
        extra_class = "user-won-banner"
        caption = "You won!"
      end

      content_tag :div, caption, class: "container game-over-banner #{extra_class}"
    end
  end

  def get_keyboard
    content_tag :table do
        content_tag :tbody do
          concat (get_keyboard_row([:Q, :W, :E, :R, :T, :Y, :U, :I, :O, :P]))
          concat (get_keyboard_row([:A, :S, :D, :F, :G, :H, :J, :K, :L]))
          concat (get_keyboard_row([:Z, :X, :C, :V, :B, :N, :M]))
      end
    end
  end

  private

  def get_keyboard_row( labels)
    content_tag :tr, class: "key-row" do
      labels.each do |i|
        concat (get_button_cell(i.to_s))
      end
    end
  end

  def get_button_cell(label)
    str = label.to_s
    extra_class = nil
    if @game.current_guesses.include? str.downcase
      extra_class = "disabled"
    end

    css_class = "btn btn-info #{extra_class}"
    content_tag :td do
      concat (button_to str, { action: "update", :guess => str}, {method: :patch, remote: true, class: css_class, disabled: (@game.current_guesses.include? str.downcase)})
    end
  end

end