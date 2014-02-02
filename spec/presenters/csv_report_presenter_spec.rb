require 'spec_helper'

describe CsvReportPresenter do
  it 'returns the column headers for the report' do
    headers = ['Name', 'Student id', 'Number of Merits', 'Number of Demerits']

    presenter = CsvReportPresenter.new(headers, [])

    expect(presenter.headers).to eq(headers)
  end

  it 'enumerates the data' do
    data = [['Ernest Hemingway', 'stu1234', 5, 2],
            ['Isaac Asimov', 'stu 5678', 1, 7]
           ]

    presenter = CsvReportPresenter.new([], data)

    presenter.each_with_index do |row, index|
      expect(row).to eq(data[index])
    end
  end
end
