class ResultsController < ApplicationController
  def index
    @data_count = Datum.count
  end
end
