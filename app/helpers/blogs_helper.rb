module BlogsHelper
    def blog_edited_date_format(blog)
        distance_of_time_in_words(blog.updated_at, DateTime.now) + " ago"
    end
end
