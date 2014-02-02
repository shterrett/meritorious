class CsvReportPresenter
  include Enumerable

  attr_reader :headers

  def initialize(headers, data)
    @headers = headers
    @data = data
  end

  def each(&block)
    data.each(&block)
  end

  private
  attr_reader :data
end
