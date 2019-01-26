require 'fileutils'
require 'digest'

require 'datastore/record'

module Tdb
  TMP_PATH = 'test/tmp'

  class Table
    attr_accessor :name, :fields, :dir_path

    def initialize(name, fields, dir_path=TMP_PATH)
      validate_dir_path

      self.name = name
      self.fields = fields
      self.dir_path = dir_path
    end

    def create
      unless File.exist?(full_dir_path)
        FileUtils.mkdir(full_dir_path)
      end
    end

    def query(selects, orders=[], filters={})
      record_file_paths = Dir["#{full_dir_path}/*"]

      # aggregate results
      record_file_paths.each do |rfp|
        record = nil

        File.open(rfp, "r") do |f|
          record = Tdb::Record.new("record_text" => f.gets)
        end

        # LEFT OFF HERE
        # filter if necessary
      end

      # order if necessary
    end

    def write_records(records)
      records.each do |record|
        write_record(record)
      end
    end

    protected

    # TODO implement
    def validate_dir_path
      return true
    end

    def write_record(record)
      File.open(full_record_path(record), "w") do |f|
        f.puts record.to_s
      end
    end
    
    def full_dir_path
      "#{self.dir_path}/#{name}.tbl"
    end

    def full_record_path(record)
      "#{full_dir_path}/#{hash_record_id(record.id)}"
    end

    def hash_record_id(id)
      Digest::SHA1.hexdigest id
    end
  end
end
