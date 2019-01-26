require "minitest/autorun"
require "datastore/table"

TEST_TMP_PATH = "#{File.expand_path(File.dirname(__FILE__))}/tmp"

class TestSimpleTable < Minitest::Test
  # TODO de-dupe this code
  def self.clear_test_tmp
    puts "Clearing test/tmp directory..."
    FileUtils.rm_rf Dir.glob("#{TEST_TMP_PATH}/*")
  end

  clear_test_tmp

  def test_table_create
    table = Tdb::Table.new("test", ["stb", "title", "date", "provider", "rev", "view_time"])
    table.create

    assert(File.exist?("#{TEST_TMP_PATH}/#{table.name}.tbl"))
  end

  def test_table_write_records
    records = [
      Tdb::Record.new("stb"=>"stb1", "title"=>"the matrix", "date"=>"2014-04-01", "provider"=>"warner bros", "rev"=>"4.00", "view_time"=>"1:30"),
      Tdb::Record.new("stb"=>"stb1", "title"=>"unbreakable", "date"=>"2014-04-03", "provider"=>"buena vista", "rev"=>"6.00", "view_time"=>"2:05"),
      Tdb::Record.new("stb"=>"stb2", "title"=>"the hobbit", "date"=>"2014-04-02", "provider"=>"warner bros", "rev"=>"8.00", "view_time"=>"2:45"),
      Tdb::Record.new("stb"=>"stb3", "title"=>"the matrix", "date"=>"2014-04-02", "provider"=>"warner bros", "rev"=>"4.00", "view_time"=>"1:05"),
    ]
    table = Tdb::Table.new("test", ["stb", "title", "date", "provider", "rev", "view_time"])
    table.write_records(records)

    records.each do |r|
      assert(File.file?("#{TEST_TMP_PATH}/#{table.name}.tbl/#{Digest::SHA1.hexdigest(r.id)}"))
    end
  end
end
