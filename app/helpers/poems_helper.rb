module PoemsHelper
    def poem_edited_date_format(poem)
        distance_of_time_in_words(poem.updated_at, DateTime.now) + " ago"
    end
end
