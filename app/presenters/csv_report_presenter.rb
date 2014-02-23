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

  def ==(other)
    data == other.data
  end

  protected
  attr_reader :data
end
