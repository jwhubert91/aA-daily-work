class LikesController < ApplicationController

    def index
        if params.has_key?(:user_id)
            likes = Like.where({user_id: params[:user_id]}) 
        elsif params.has_key?(:artwork_id)
            likes = Like.where({artwork_id: params[:artwork_id]}) 
        elsif params.has_key?(:comment_id)
            likes = Like.where({comment_id: params[:comment_id]})
        else
            likes = Like.all
        end

        render json: likes
    end

    def create
        like = Like.new(like_params)

        if like.save
            render json: like
        else
            render json: like.errors.full_messages, status: 422
        end
    end

    def show
        like = Like.find(params[:id])
        
        render json: like
    end

    def update
        like = Like.find(params[:id])

        if like.update(like_params)
            render json: like
        else
            render json: like.errors.full_messages, status: 422
        end

    end

    def destroy
        like = Like.find(params[:id])

        like.destroy

        render json: "like successfully deleted"

    end

    private
    def like_params
        params.require(:like).permit(:user_id, :artwork_id, :comment_id)
    end

end