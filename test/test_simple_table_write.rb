require "minitest/autorun"
require "datastore/table"
require_relative "constants"

class TestSimpleTableWrite < Minitest::Test
  def test_table_create
    table = Tdb::Table.new("simple_test")
    table.create

    assert(File.exist?("#{TestConstants::TEST_TMP_PATH}/#{table.name}.tbl"))
  end

  def test_simple_table_write
    records = [
      Tdb::Record.new("stb"=>"stb1", "title"=>"the matrix", "date"=>"2014-04-01", "provider"=>"warner bros", "rev"=>"4.00", "view_time"=>"1:30"),
      Tdb::Record.new("stb"=>"stb1", "title"=>"unbreakable", "date"=>"2014-04-03", "provider"=>"buena vista", "rev"=>"6.00", "view_time"=>"2:05"),
      Tdb::Record.new("stb"=>"stb2", "title"=>"the hobbit", "date"=>"2014-04-02", "provider"=>"warner bros", "rev"=>"8.00", "view_time"=>"2:45"),
      Tdb::Record.new("stb"=>"stb3", "title"=>"the matrix", "date"=>"2014-04-02", "provider"=>"warner bros", "rev"=>"4.00", "view_time"=>"1:05"),
    ]
    table = Tdb::Table.new("simple_test_2")
    table.create

    table.write(records)

    records.each do |r|
      assert(File.file?("#{TestConstants::TEST_TMP_PATH}/#{table.name}.tbl/#{Digest::SHA1.hexdigest(r.id)}"))
    end
  end
end
