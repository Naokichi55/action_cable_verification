class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      ActionCable.server.broadcast('comments_channel',{ body: @comment, date: @comment.created_at.strftime('%Y/%m/%d %H:%M'), user: @comment.user, id: @comment.id,racket: @comment.racket })
      # redirect_to racket_path(comment.racket), success: "コメント投稿に成功しました"
    else
      redirect_to racket_path(comment.racket), danger: "コメント投稿に失敗しました"
    end
  end

  def destroy
    comment = current_user.comments.find(params[:id])
    comment.destroy!
    if comment.destroy
      ActionCable.server.broadcast 'delete_channel', id: comment.id
    end
    redirect_to racket_path(comment.racket), success: "コメントを削除しました。"
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(racket_id: params[:racket_id])
  end
end
