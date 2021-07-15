class BlogsController < ApplicationController
    def index
        @blogs = current_user.blogs
    end

    def show
        @blog = Blog.find(params[:id])
    end

    def new
        @blog = Blog.new
    end
    def create
        @blog = Blog.new(blog_params)

        if @blog.valid?
            @blog.save
            @blog.update(last_editor: current_user.full_name, edited?: false)
            BlogContributor.create(user_id: current_user.id, blog_id: @blog.id)
            
            if params[:blog][:add_a_writer] != ""
                new_contributor = @blog.find_user(params[:blog][:add_a_writer])
    
                if new_contributor
                    @blog.users << new_contributor
                    redirect_to @blog
                else
                    flash[:errors] = ["Username not found. Please enter a valid username."]
                    render :new
                end
            else
                redirect_to @blog
            end
        else
            flash[:errors] = @blog.errors.full_messages

            if params[:blog][:add_a_writer] != ""
                new_contributor = @blog.find_user(params[:essay][:add_a_writer])
    
                if !new_contributor
                    flash[:errors] << "Username not found. Please enter a valid username."
                end
            end
            render :new
        end
    end

    def edit
        @blog = Blog.find(params[:id])
    end

    def update
        @blog = Blog.find(params[:id])
        @blog.update(blog_params)
        @blog.update(last_editor: current_user.full_name, edited?: true)

        if @blog.valid?
            if params[:blog][:add_a_writer] != ""
                new_contributor = @blog.find_user(params[:blog][:add_a_writer])
    
                if new_contributor
                    @blog.users << new_contributor
                    redirect_to @blog
                else
                    flash[:errors] = ["Username not found. Please enter a valid username."]
                    render :edit
                end
            else
                redirect_to @blog
            end
        else
            flash[:errors] = @blog.errors.full_messages

            if params[:blog][:add_a_writer] != ""
                new_contributor = @blog.find_user(params[:blog][:add_a_writer])
    
                if !new_contributor
                    flash[:errors] << "Username not found. Please enter a valid username."
                end
            end
            render :edit
        end
    end


    private

    def blog_params
        params.require(:blog).permit(:title, :content, :topic)
    end
end
