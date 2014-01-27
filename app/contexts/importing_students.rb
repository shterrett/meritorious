class ImportingStudents
  def initialize(file, classroom)
    @file = file
    @classroom = classroom
  end

  def import
    importer = StudentImporter.new(@file, @classroom)
    importer.import
    importer.row_errors
  end
end
