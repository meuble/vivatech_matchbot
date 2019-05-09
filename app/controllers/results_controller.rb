class ResultsController < ApplicationController
  def index
    @data_count = Datum.count
    @skin_type_results = Datum.skin_type_results
  end
end
