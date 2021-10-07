# frozen_string_literal: true

class ProfileController < ApplicationController
  def profile
    @param = params[:id]
    @user = User.find_by(name: @param)

    # ユーザーがない場合は404エラー
    raise ActionController.RoutingError if @user.nil?

    @twitter_url = "https://twitter.com/#{@param}"
    @edit_path = "/#{@param}/edit"
    description = Description.find_by(user_id: @user.id)

    redirect_to @edit_path if description.nil? # 本人でかつ詳細情報が登録されていない場合

    # 言語の配列を作成する
    languages = Language.all.map { |o| [o.id, o.name] }.to_h
    if description.nil?
      @title = ''
      @comment = ''
      @languages = nil
    else
      @title = description.title
      @comment = description.comment
      @languages = [
        languages[description.language1],
        languages[description.language2],
        languages[description.language3],
        languages[description.language4],
        languages[description.language5]
      ].compact
    end
  end

  def edit
    user = User.find_by(name: params[:id])
    description = Description.find_by(user_id: user.id)
    @languages = Language.all.map { |o| [o.name, o.id] }
    if description.nil?
      @title = ''
      @comment = ''
      @language1 = ''
      @language2 = ''
      @language3 = ''
      @language4 = ''
      @language5 = ''
    else
      @title = description.title
      @comment = description.comment
      @language1 = description.language1
      @language2 = description.language2
      @language3 = description.language3
      @language4 = description.language4
      @language5 = description.language5
    end
    @profile_path = "/#{params[:id]}"
    @profile_edit_path = "/#{params[:id]}/edit"
  end

  def edit_post
    user = User.find_by(name: params[:id])
    # descriptionを登録する
    description = Description.find_by(user_id: user.id)
    if description.nil?
      Description.create(
        title: params[:title],
        comment: params[:comment],
        user_id: user.id,
        language1: params[:language1],
        language2: params[:language2],
        language3: params[:language3],
        language4: params[:language4],
        language5: params[:language5]
      )
    else
      description.title = params[:title]
      description.comment = params[:comment]
      description.language1 = params[:language1]
      description.language2 = params[:language2]
      description.language3 = params[:language3]
      description.language4 = params[:language4]
      description.language5 = params[:language5]
      description.save
    end

    redirect_to "/#{params[:id]}"
  end
end
