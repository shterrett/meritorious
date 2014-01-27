require 'csv'

class StudentImporter
  IMPORTER_OPTIONS = { col_sep: ',', quote_char: '%', headers: true, header_converters: :symbol }
  ATTRIBUTES = [:first_name, :last_name, :email, :student_id]

  attr_reader :row_errors

  def initialize(csv_file, classroom)
    @file = csv_file
    @classroom = classroom
    @school = classroom.school
    @row_errors = Hash.new([])
  end

  def import
    csv.each { |row | add_student(student_params(row)) }
  end

  private
  attr_reader :classroom, :file, :school
  attr_writer :row_errors

  def csv
    @csv ||= if file
               CSV.parse(file.read, IMPORTER_OPTIONS)
             end
  end

  def add_student(params)
    student(params).tap do |student|
      puts student.inspect
      if student.valid?
        ActiveRecord::Base.transaction do
          student.save
          add_to_classroom(student)
        end
      else
        row_errors[error_key(params)] += student.errors.full_messages
      end
    end
  end

  def student(params)
    school.students
      .where(student_id: params[:student_id])
      .first_or_initialize(params)
  end

  def student_params(row)
    row.to_hash.slice(*ATTRIBUTES)
  end

  def add_to_classroom(student)
    unless classroom.students.include? student
      classroom.students << student
    end
  end

  def error_key(row)
    [row[:first_name], row[:last_name], row[:student_id]].compact.join(' ')
  end
end