module UsersHelper
  
  def get_friendship_with_user_id(user)
    f = current_user.friendships.with_user(user)[0]
    i = current_user.inverse_friendships.with_user(user)[0]
    if f.nil?
      i
    elsif i.nil?
      f
    end
  end
  
end
