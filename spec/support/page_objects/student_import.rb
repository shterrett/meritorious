class StudentImport < PageObject::Base
  def initialize(classroom)
    @classroom = classroom
  end

  def import_file(file_name)
    attach_file 'student_imports', full_path(file_name)
    click_button 'Import Students'
  end

  def has_success_flash?
    page.has_content? 'Students successfully imported'
  end

  def has_error_flash?
    page.has_content? 'There were errors in the import'
  end

  def has_student?(name)
    page.has_css? '[data-role="student"]', text: name
  end

  def has_error?(error)
    within '#import-errors' do
      page.has_content? error
    end
  end

  private
  attr_reader :classroom

  def full_path(file_name)
    Rails.root.join('spec', 'data', 'importers', file_name)
  end
end
