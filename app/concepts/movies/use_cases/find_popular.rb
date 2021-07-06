# frozen_string_literal: true

module Movies
  module UseCases
    class FindPopular
      attr_reader :repository, :params

      def initialize(params:, repository: Repository.new)
        @repository = repository
        @params = params
      end

      def call
        validate!
        repository.find_popular(params_ratio: params[:ratio])
      end

      private

      def validate!
        Validators::PaginationValidator.new(pagination: params[:pagination]).validate!
      end

      def search_by_input
        repository.find_by(search: params[:search])
      end

      def search_by_screening
        case params[:filter].keys.first
        when "genre_id"
          repository.find_filter(filter: params[:filter])
        when "display_type_id"
          repository.join_filter(filter: display_type)
        when "voice_type_id"
          repository.join_filter(filter: voice_type)
        end
      end

      def display_type
        { display_type_id: params[:filter][:display_type_id] }
      end

      def voice_type
        { voice_type_id: params[:filter][:voice_type_id] }
      end
    end
  end
end
