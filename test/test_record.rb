require "minitest/autorun"
require_relative "../datastore/record"

class TestRecord < Minitest::Test
  def test_record_creation
    Tdb::Record.new("stb1", "the matrix", "warner bros", "2014-04-01", "4.00", "1:30")
  end

  def test_record_creation_failure
    assert_raises Tdb::Error::InvalidId do
      Tdb::Record.new("stb1", "the matrix", nil, "2014-04-01", "4.00", "1:30")
    end
  end

  def test_string_conversion
    assert_equal(Tdb::Record.new("stb1", "the matrix", "2014-04-01", "warner bros", "4.00", "1:30").to_s, "stb1|the matrix|2014-04-01|warner bros|4.00|1:30") 
  end

  def test_id
    assert_equal(Tdb::Record.new("stb1", "the matrix", "2014-04-01", "warner bros", "4.00", "1:30").id, "stb1the matrix2014-04-01")
  end
end
