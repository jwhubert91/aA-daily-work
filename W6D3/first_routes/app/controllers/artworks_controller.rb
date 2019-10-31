# class ArticlesController
#   def index
#     if params.has_key?(:magazine_id)
#       # index of nested resource
#       @articles = Article.where(magazine_id: params[:magazine_id])
#     else
#       # index of top-level resource
#       @articles = Article.all
#     end

#     render json: @articles
#   end
# end
# user_artworks 
# GET    /users/:user_id/artworks(.:format)                                                       artworks#index
# GET    /users(.:format)                                                                         users#index
# POST   /users(.:format) 

class ArtworksController < ApplicationController

    def index
            if params.has_key?(:user_id)
                artworks = Artwork.where({artist_id: params[:user_id]}) 
            else
                artworks = Artwork.all
            end

            render json: artworks
    end

    def create
        artwork = Artwork.new(artwork_params)

        if artwork.save
            render json: artwork
        else
            render json: artwork.errors.full_messages, status: 422
        end
    end

    def show
        artwork = Artwork.find(params[:id])
        
        render json: artwork
    end

    def update
        artwork = Artwork.find(params[:id])

        if artwork.update(artwork_params)
            render json: artwork
        else
            render json: artwork.errors.full_messages, status: 422
        end

    end

    def destroy
        artwork = Artwork.find(params[:id])

        artwork.destroy

        render json: "artwork #{artwork[:title]} successfully deleted"

    end

    private
    def artwork_params
        params.require(:artwork).permit(:title, :artist_id, :image_url)
    end

end