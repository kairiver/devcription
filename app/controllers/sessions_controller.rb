class SessionsController < ApplicationController
  def create
    unless request.env['omniauth.auth'][:uid]
      flash[:danger] = '連携に失敗しました'
      redirect_to '/'
    end
    user_data = request.env['omniauth.auth']
    user = User.find_by(uid: user_data[:uid])
    if user
      session[:uid] = user.uid
      user.nickname = user_data[:info][:nickname]
      user.name = user_data[:info][:name]
      user.image = (user_data[:info][:image]).gsub!('_normal.jpg', '.jpg')
      user.save
      flash[:success] = 'ログインしました'
    else
      new_user = User.new(
        uid: user_data[:uid],
        nickname: user_data[:info][:nickname],
        name: user_data[:info][:name],
        image: (user_data[:info][:image]).gsub!('_normal.jpg', '.jpg')
      )
      if new_user.save
        session[:uid] = user_data[:uid]
        flash[:success] = 'ユーザー登録成功'
      else
        flash[:danger] = '予期せぬエラーが発生しました'
      end
    end
    redirect_to "/#{user_data[:info][:nickname]}"
  end

  def destroy
    session.delete(:uid)
    redirect_to '/'
  end
end