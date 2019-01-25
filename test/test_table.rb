require "minitest/autorun"

require "./datastore/table"
#require_relative "../datastore/record"

class TestTable < Minitest::Test
  def setup
    @records = [
      Tdb::Record.new("stb1", "the matrix", "2014-04-01", "warner bros", "4.00", "1:30"),
      Tdb::Record.new("stb1", "unbreakable", "2014-04-03", "buena vista", "6.00", "2:05"),
      Tdb::Record.new("stb2", "the hobbit", "2014-04-02", "warner bros", "8.00", "2:45"),
      Tdb::Record.new("stb3", "the matrix", "2014-04-02", "warner bros", "4.00", "1:05"),
    ]
  end

  def test_table_write
    table = Tdb::Table.new("test", ["stb", "title", "date", "provider", "rev", "view_time"])
    table.write(@records)
  end
end
