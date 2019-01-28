require 'fileutils'
require 'digest'

require 'datastore/record'

module Tdb
  TMP_PATH = 'test/tmp'

  class InvalidQueryFilter < StandardError; end

  class Table
    attr_accessor :name, :dir_path

    def initialize(name, dir_path=TMP_PATH)
      validate_dir_path

      self.name = name
      self.dir_path = dir_path
    end

    def create
      FileUtils.mkdir(full_dir_path)
    end

    # optional params - orders, filters
    def query(args={})
      record_file_paths = Dir["#{full_dir_path}/*"]

      matched_records = []

      # aggregate results
      record_file_paths.each do |rfp|
        record = nil

        File.open(rfp, "r") do |f|
          record = Tdb::Record.new("record_text"=>f.gets)
        end

        matched_records << record if !args["filters"] || include_record?(record, args["filters"])
      end

      if args["orders"]
        matched_records = matched_records.sort_by {|r|
          args["orders"].collect {|o| r.instance_variable_get("@#{o}")}
        }
      end

      matched_records
    end

    def write(records)
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

    def include_record?(record, filters)
      include_record = true

      if filters.length > 0
        filters.each do |k,v|
          begin
            include_record = record.send(k) == v
          rescue NoMethodError
            raise Tdb::InvalidQueryFilter, "Invalid filter named: #{k}"
          end

          break unless include_record
        end
      end

      include_record
    end
  end
end
