require "minitest/autorun"
require "datastore/table"
require_relative "constants"

class TestComplexTable < Minitest::Test
  def test_table_overwrite_records
    table = Tdb::Table.new("complex_test")
    table.create

    records = [
      Tdb::Record.new("stb"=>"stb1", "title"=>"the matrix", "date"=>"2014-04-01", "provider"=>"warner bros", "rev"=>"4.00", "view_time"=>"1:30"),
      Tdb::Record.new("stb"=>"stb1", "title"=>"unbreakable", "date"=>"2014-04-03", "provider"=>"buena vista", "rev"=>"6.00", "view_time"=>"2:05"),
      Tdb::Record.new("stb"=>"stb2", "title"=>"the hobbit", "date"=>"2014-04-02", "provider"=>"warner bros", "rev"=>"8.00", "view_time"=>"2:45"),
      Tdb::Record.new("stb"=>"stb3", "title"=>"the matrix", "date"=>"2014-04-02", "provider"=>"warner bros", "rev"=>"4.00", "view_time"=>"1:05")
    ]

    table.write_records(records)

    more_records = [
      Tdb::Record.new("stb"=>"stb1", "title"=>"the matrix", "date"=>"2014-04-01", "provider"=>"UPDATED FIELD", "rev"=>"4.00", "view_time"=>"1:30"),
      Tdb::Record.new("stb"=>"stb4", "title"=>"the departed", "date"=>"2014-04-04", "provider"=>"no idea", "rev"=>"6.00", "view_time"=>"2:10")
    ]

    table.write_records(more_records)

    [records, more_records[1]].flatten.each do |r|
      assert(File.file?("#{TestConstants::TEST_TMP_PATH}/#{table.name}.tbl/#{Digest::SHA1.hexdigest(r.id)}"))
    end

    File.open("#{TestConstants::TEST_TMP_PATH}/#{table.name}.tbl/#{Digest::SHA1.hexdigest(more_records[0].id)}", "r") do |f|
      assert(f.gets.include?("UPDATED FIELD"))
    end
  end
end
