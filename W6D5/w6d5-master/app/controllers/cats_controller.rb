class CatsController < ApplicationController
    def index
        @cats = Cat.all.to_a

        render :index
    end

    def show
        @cat = Cat.find_by(id: params[:id])
      

        if @cat 
            render :show
        else
            redirects_to cats_url
        end
    end

    def new
        render :new
    end

    def create

    end

    def update

    end
end