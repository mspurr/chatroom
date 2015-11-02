module UsersHelper
  def action_buttons(user)
    case current_user.friendship_status(user) when "friends"
      '<span class="default_btn_gray abs p_fr_btn hover_abs">'.html_safe + '<i class="fa fa-check-circle"></i>'.html_safe + 'Friends' + '<i class="fa fa-angle-right i_btn_pos"></i>'.html_safe + (link_to 'Remove Friend <i class="fa fa-ban"></i>'.html_safe, friendship_path(current_user.friendship_relation(user)), class: "hidden_hover_btn", method: :delete) + '</span>'.html_safe
      #link_to '<i class="fa fa-check-circle"></i>'.html_safe + "Friends", friendship_path(current_user.friendship_relation(user)), class: "default_btn_gray abs p_fr_btn", method: :delete
    when "pending"
      link_to '<i class="fa fa-ban"></i>'.html_safe + "Cancel Request", friendship_path(current_user.friendship_relation(user)), class: "default_btn_gray abs p_cancel_btn", method: :delete
    when "requested"
      link_to '<i class="fa fa-check"></i>'.html_safe + "Accept", accept_friendship_path(current_user.friendship_relation(user)), class: "default_btn_gray abs p_cancel_btn", method: :put
    when "not_friends"
      link_to friendships_path(user_id: user.id), class: "default_btn_gray abs p_add_btn", method: :post do
        '<i class="ion-person-add"></i>'.html_safe + 'Add Friend'
      end
    end
  end
end
