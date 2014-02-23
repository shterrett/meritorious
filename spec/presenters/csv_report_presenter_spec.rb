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

  context 'testing for equality' do
    it 'it equal when the data is the same' do
      data = [['Ernest Hemingway', 'stu1234', 5, 2],
              ['Isaac Asimov', 'stu 5678', 1, 7]
             ]

      presenter = CsvReportPresenter.new([], data)
      presenter_2 = CsvReportPresenter.new([], data)

      expect(presenter == presenter_2).to be_true
    end

    it 'is not equal when the data is not the same' do
      data = [['Ernest Hemingway', 'stu1234', 5, 2],
              ['Isaac Asimov', 'stu 5678', 1, 7]
             ]

      presenter = CsvReportPresenter.new([], data)

      data_2 = [['Herman Melville', 'stu4321', 3, 2],
                ['Phillip Dick', 'stu 7648', 1, 2]
               ]

      presenter_2 = CsvReportPresenter.new([], data_2)

      expect(presenter == presenter_2).to be_false
    end
  end
end
