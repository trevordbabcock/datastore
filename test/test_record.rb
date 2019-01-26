require "minitest/autorun"
require_relative "../datastore/record"

class TestRecord < Minitest::Test
  def test_record_creation
    Tdb::Record.new("stb" => "stb1", "title" => "the matrix", "provider" => "warner bros", "date" => "2014-04-01", "rev" => "4.00", "view_time" => "1:30")
  end

  def test_record_creation_failure
    assert_raises Tdb::Error::InvalidId do
      Tdb::Record.new("stb" => "stb1", "title" => "the matrix", "provider" => "warner bros", "rev" => "4.00", "view_time" => "1:30")
    end
  end

  def test_string_conversion
    assert_equal(Tdb::Record.new("stb" => "stb1", "title" => "the matrix", "date" => "2014-04-01", "provider" => "warner bros", "rev" => "4.00", "view_time" => "1:30").to_s, "stb1|the matrix|warner bros|2014-04-01|4.00|1:30") 
  end

  def test_id
    assert_equal(Tdb::Record.new("stb" => "stb1", "title" => "the matrix", "date" => "2014-04-01", "provider" => "warner bros", "rev" => "4.00", "view_time" => "1:30").id, "stb1the matrix2014-04-01")
  end

  def test_record_text
    record = Tdb::Record.new("record_text" => "stb1|the matrix|warner bros|2014-04-01|4.00|1:30")
    assert_equal(record.stb, "stb1")
    assert_equal(record.title, "the matrix")
    assert_equal(record.provider, "warner bros")
    assert_equal(record.date, "2014-04-01")
    assert_equal(record.rev, "4.00")
    assert_equal(record.view_time, "1:30")
  end
end
