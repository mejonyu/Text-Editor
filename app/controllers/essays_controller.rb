class EssaysController < ApplicationController
    def index
        @essays = current_user.essays
    end

    def show
        @essay = Essay.find(params[:id])
    end

    def new
        @essay = Essay.new
    end

    def create
        @essay = Essay.new(essay_params)

        if @essay.valid?
            @essay.save
            EssayContributor.create(user_id: current_user.id, essay_id: @essay.id)
            redirect_to @essay
        else
            flash[:errors] = @essay.errors.full_messages
            redirect_to new_essay_path
        end
    end

    def edit
        @essay = Essay.find(params[:id])
    end

    def update
        @essay = Essay.find(params[:id])
        @essay.update(essay_params)
        redirect_to @essay
    end

    private

    def essay_params
        params.require(:essay).permit(:title, :content, :essay_type)
    end
end
