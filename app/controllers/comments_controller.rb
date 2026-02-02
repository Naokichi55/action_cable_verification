class CommentsController < ApplicationController

def create
  @racket = Racket.find(params[:racket_id])
  @comment = current_user.comments.build(comment_params)
  @comment.user = current_user

  if @comment.save
      CommentsChannel.broadcast_to(
        "racket_#{@racket.id}_comments",
        {
          action: 'create', #destoryアクションを追加するにあたりアクション分けを追加
          comment: render_to_string(
          partial: 'comments/comment',
          locals: { comment: @comment }
          )
        }
      )
    else
      redirect_to racket_path(comment.racket), danger: "コメント投稿に失敗しました"
  end
end

# コメントアウトにする
  # def create
  #   @comment = current_user.comments.build(comment_params)
  #   if @comment.save
  #     ActionCable.server.broadcast('comments_channel',{ body: @comment, date: @comment.created_at.strftime('%Y/%m/%d %H:%M'), user: @comment.user, id: @comment.id,racket: @comment.racket })
  #     redirect_to racket_path(@comment.racket), success: "コメント投稿に成功しました"
  #   else
  #     redirect_to racket_path(comment.racket), danger: "コメント投稿に失敗しました"
  #   end
  # end

  def destroy
    @comment = current_user.comment.find(params[:id])
    @racket = @comment.racket
    @comment.destroy

    CommentChannel.broadcast_to(
      @racket,
      {
        action: 'destroy',
        comment_id: @comment.id
      }

    )
  end

  #　コメント投稿機能と分けるためにコードを分けて記載
  # def destroy
  #   comment = current_user.comments.find(params[:id])
  #   comment.destroy!
  #   if comment.destroy
  #     ActionCable.server.broadcast 'delete_channel', id: comment.id
  #   end
  #   redirect_to racket_path(comment.racket), success: "コメントを削除しました。"
  # end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(racket_id: params[:racket_id])
  end
end
