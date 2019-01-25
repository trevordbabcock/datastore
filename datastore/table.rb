require 'fileutils'

require 'datastore/record'

module Tdb
  TMP_PATH = 'test/tmp'

  class Table
    attr_accessor :name, :fields, :file_path

    def initialize(name, fields, file_path=TMP_PATH)
      validate_file_path

      self.name = name
      self.fields = fields
      self.file_path = file_path
    end

    def read
      # open file
      # aggregate results
      # filter if necessary
    end

    # TODO make smarter regarding overwriting existing records with the same id
    def write(records)
      full_file_path = "#{self.file_path}/#{name}.tbl"
      #FileUtils.touch(full_file_path)

      File.open(full_file_path, 'a') do |f|
        records.each do |r|
          f.puts(r.to_s)
        end
      end
    end

    protected

    # TODO implement
    def validate_file_path
      return true
    end
  end
end
