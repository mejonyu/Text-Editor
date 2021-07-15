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
            @essay.update(last_editor: current_user.full_name, edited?: false)
            EssayContributor.create(user_id: current_user.id, essay_id: @essay.id)
            
            if params[:essay][:add_a_writer] != ""
                new_contributor = @essay.find_user(params[:essay][:add_a_writer])
    
                if new_contributor
                    @essay.users << new_contributor
                    redirect_to @essay
                else
                    flash[:errors] = ["Username not found. Please enter a valid username."]
                    render :new
                end
            else
                redirect_to @essay
            end
        else
            flash[:errors] = @essay.errors.full_messages

            if params[:essay][:add_a_writer] != ""
                new_contributor = @essay.find_user(params[:essay][:add_a_writer])
    
                if !new_contributor
                    flash[:errors] << "Username not found. Please enter a valid username."
                end
            end
            render :new
        end
    end

    def edit
        @essay = Essay.find(params[:id])
    end

    def update
        @essay = Essay.find(params[:id])
        @essay.update(essay_params)
        @essay.update(last_editor: current_user.full_name, edited?: true)

        if @essay.valid?
            if params[:essay][:add_a_writer] != ""
                new_contributor = @essay.find_user(params[:essay][:add_a_writer])
    
                if new_contributor
                    @essay.users << new_contributor
                    redirect_to @essay
                else
                    flash[:errors] = ["Username not found. Please enter a valid username."]
                    render :edit
                end
            else
                redirect_to @essay
            end
        else
            flash[:errors] = @essay.errors.full_messages

            if params[:essay][:add_a_writer] != ""
                new_contributor = @essay.find_user(params[:essay][:add_a_writer])
    
                if !new_contributor
                    flash[:errors] << "Username not found. Please enter a valid username."
                end
            end
            render :edit
        end
    end

    def destroy
        @essay = Essay.find(params[:id])
        @essay.destroy
        redirect_to essays_path, notice: "Your essay has been deleted."
    end

    private

    def essay_params
        params.require(:essay).permit(:title, :content, :essay_type)
    end
end
