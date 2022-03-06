class SearchController < ApplicationController
  def search_service
    render json: FileSearcher.read_file_and_search_services(params), status: :ok
  end
end
