module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def declension(number, vopros, voprosa, voprosov)
    if number.nil? || !number.is_a?(Numeric)
      number = 0
    end

    return voprosov if number >= 11 && number <= 14

    remainder = number % 10
    remainder2 = number % 100

    return vopros if remainder == 1
    return voprosa if remainder >= 2 && remainder <= 4
    return voprosov if (remainder >= 5 && remainder <= 9) || remainder.zero?
    return voprosov if remainder2 >= 11 && remainder2 <= 14
  end
end