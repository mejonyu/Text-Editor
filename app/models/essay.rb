class Essay < ApplicationRecord
    attr_accessor :add_a_writer

    has_many :essay_contributors
    has_many :users, through: :essay_contributors

    validates :title, presence: true, length: { maximum: 60 }
    validates :content, presence: true

    TYPES = ["Narrative", "Descriptive", "Expository", "Persuasive"]

    def self.types
        TYPES
    end

    def contributors
        writers = self.users.map do |user|
            user.first_name + " " + user.last_name 
        end
        writers.to_sentence
    end

    def find_user(username)
        User.find_by(username: username)
    end

    def created_or_edited
        if self.edited?
            "edited"
        else
            "created"
        end
    end

    private

    def to_sentence(options = {})
        options.assert_valid_keys(:words_connector, :two_words_connector, :last_word_connector, :locale)

        default_connectors = {
            words_connector: ", ",
            two_words_connector: " and ",
            last_word_connector: ", and "
        }
        if defined?(I18n)
            i18n_connectors = I18n.translate(:'support.array', locale: options[:locale], default: {})
            default_connectors.merge!(i18n_connectors)
        end
        options = default_connectors.merge!(options)

        case length
        when 0
        ""
        when 1
        "#{self[0]}"
        when 2
        "#{self[0]}#{options[:two_words_connector]}#{self[1]}"
        else
        "#{self[0...-1].join(options[:words_connector])}#{options[:last_word_connector]}#{self[-1]}"
        end
    end
end
