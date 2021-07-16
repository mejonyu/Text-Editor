module EssaysHelper
    def essay_edited_date_format(essay)
        distance_of_time_in_words(essay.updated_at, DateTime.now) + " ago"
    end
end
