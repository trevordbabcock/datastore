require "minitest/autorun"
require "datastore/table"
require_relative "constants"


class TestTableQuery < Minitest::Test
  # integration test
  def test_select_query
    table = Tdb::Table.new("query_test")
    table.create

    records = [
      Tdb::Record.new("stb"=>"stb1", "title"=>"the matrix", "date"=>"2014-04-01", "provider"=>"warner bros", "rev"=>"4.00", "view_time"=>"1:30"),
      Tdb::Record.new("stb"=>"stb1", "title"=>"unbreakable", "date"=>"2014-04-03", "provider"=>"buena vista", "rev"=>"6.00", "view_time"=>"2:05"),
      Tdb::Record.new("stb"=>"stb2", "title"=>"the hobbit", "date"=>"2014-04-02", "provider"=>"warner bros", "rev"=>"8.00", "view_time"=>"2:45"),
      Tdb::Record.new("stb"=>"stb3", "title"=>"the matrix", "date"=>"2014-04-02", "provider"=>"warner bros", "rev"=>"4.00", "view_time"=>"1:05"),
    ]
    table.write_records(records)

    expected_records = [
      "the matrix,4.00,2014-04-02",
      "the hobbit,8.00,2014-04-02",
      "unbreakable,6.00,2014-04-03",
      "the matrix,4.00,2014-04-01"
    ]

    queried_records = table.query()
    assert_equal(4, queried_records.count)

    queried_records.each_with_index do |r,i|
      assert_equal(r.to_s("selections"=>["title", "rev", "date"], "delimiter"=>","), expected_records[i])
    end

    expected_ordered_records = [
      "the matrix,4.00,2014-04-01",
      "the hobbit,8.00,2014-04-02",
      "the matrix,4.00,2014-04-02",
      "unbreakable,6.00,2014-04-03"
    ]

    queried_records = table.query("orders"=>["date", "title"])
    assert_equal(4, queried_records.count)
  
    queried_records.each_with_index do |r,i|
      assert_equal(r.to_s("selections"=>["title", "rev", "date"], "delimiter"=>","), expected_ordered_records[i])
    end

    expected_filtered_records = [
      "the matrix,4.00,2014-04-01"
    ]

    queried_records = table.query("filters"=>{"date"=>"2014-04-01"})
    assert_equal(1, queried_records.count)

    queried_records.each_with_index do |r,i|
      assert_equal(r.to_s("selections"=>["title", "rev", "date"], "delimiter"=>","), expected_filtered_records[i])
    end
  end
end
