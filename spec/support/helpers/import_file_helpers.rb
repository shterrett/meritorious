module ImportFileHelpers
  def uploaded_file(file_name)
    Rack::Test::UploadedFile.new(Rails.root.join('spec', 'data', 'importers', file_name), 'text/csv')
  end
end
