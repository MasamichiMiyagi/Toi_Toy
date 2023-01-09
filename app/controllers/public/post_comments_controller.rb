class Public::PostCommentsController < ApplicationController
  #before_action :is_matching_login_customer, only: [:create, :destroy]

  def create
    @game = Game.find(params[:game_id])
    comment = current_customer.post_comments.new(post_comment_params)
    comment.game_id = @game.id
    if comment.save
      redirect_to game_path(@game)
    else
      render :create
    end
  end

  def destroy
    @game = Game.find(params[:game_id])
    PostComment.find(params[:id]).destroy
    redirect_to game_path(@game)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

  #def is_matching_login_customer
    #@game = Game.find(params[:game_id])
    #login_customer_id = current_customer.id
    #if(post_comment.customer_id != login_customer_id)
      #redirect_to game_path
    #end
  #end
end
