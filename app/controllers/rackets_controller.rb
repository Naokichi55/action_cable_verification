class RacketsController < ApplicationController
 # 未ログインだとログイン画面への遷移するヘルパーメソッドを設定
  before_action :authenticate_user!, only: %i[edit new]

  def index
    @rackets = Racket.includes(:user)  # ラケット一覧を取得
  end

  def new
    @racket = Racket.new
  end

  def create
    @racket = current_user.rackets.build(racket_params)
    if @racket.save
      redirect_to rackets_path, success: "ラケットを投稿しました。"
    else
      flash.now[:danger] = "ラケット投稿に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  # 詳細ページへのアクション
  def show
    @racket = Racket.find(params[:id])
    # コメントに関するアクション
    @comment = Comment.new
    @comments = @racket.comments.includes(:user).order(created_at: :desc)
  end

  # 投稿したラケット情報を更新するためのアクション
  def update
    @racket = Racket.find(params[:id])
    if @racket.update(racket_params)
      redirect_to racket_path(@racket), success: "ラケットをアップデートしました。"
    else
      flash.now[:danger] = "ラケット投稿に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  # ラケット編集ページへのアクション
  def edit
    @racket = current_user.rackets.find(params[:id])
  end

  # ラケットの投稿削除アクション
  def destroy
    racket = current_user.rackets.find(params[:id])
    racket.destroy!
    redirect_to rackets_path, success: "ラケット削除しました。"
  end


  private
  def racket_params
    params.require(:racket).permit(:product_name, :maker_name, :face_size, :main_string, :cross_string, :main_string_tension, :cross_string_tension,  :weight_position, :grip_size, :grip_tape, :body )
  end
end
