class PoemsController < ApplicationController
    def index
        @poems = current_user.poems
    end

    def show
        @poem = Poem.find(params[:id])
    end

    def new
        @poem = Poem.new
    end

    def create
        @poem = Poem.new(poem_params)

        if @poem.valid?
            @poem.save
            @poem.update(last_editor: current_user.full_name, edited?: false)
            PoemContributor.create(user_id: current_user.id, poem_id: @poem.id)
            
            if params[:poem][:add_a_writer] != ""
                new_contributor = @poem.find_user(params[:poem][:add_a_writer])
    
                if new_contributor
                    @poem.users << new_contributor
                    redirect_to @poem
                else
                    flash[:errors] = ["Username not found. Please enter a valid username."]
                    render :new
                end
            else
                redirect_to @poem
            end
        else
            flash[:errors] = @poem.errors.full_messages

            if params[:poem][:add_a_writer] != ""
                new_contributor = @poem.find_user(params[:poem][:add_a_writer])
    
                if !new_contributor
                    flash[:errors] << "Username not found. Please enter a valid username."
                end
            end
            render :new
        end
    end

    def edit
        @poem = Poem.find(params[:id])
    end

    def update
        @poem = Poem.find(params[:id])
        @poem.update(poem_params)
        @poem.update(last_editor: current_user.full_name, edited?: true)

        if @poem.valid?
            if params[:poem][:add_a_writer] != ""
                new_contributor = @poem.find_user(params[:poem][:add_a_writer])
    
                if new_contributor
                    @poem.users << new_contributor
                    redirect_to @poem
                else
                    flash[:errors] = ["Username not found. Please enter a valid username."]
                    render :edit
                end
            else
                redirect_to @poem
            end
        else
            flash[:errors] = @poem.errors.full_messages

            if params[:poem][:add_a_writer] != ""
                new_contributor = @poem.find_user(params[:poem][:add_a_writer])
    
                if !new_contributor
                    flash[:errors] << "Username not found. Please enter a valid username."
                end
            end
            render :edit
        end
    end


    private

    def poem_params
        params.require(:poem).permit(:title, :content, :poem_type)
    end
end
