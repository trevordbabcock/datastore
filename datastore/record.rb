module Tdb
  module Error
    class InvalidId < StandardError; end
  end

  class Record
    attr_accessor :stb, :title, :date, :provider, :rev, :view_time

    def initialize(stb, title, date, provider=nil, rev=nil, view_time=nil)
      validate_id(stb, title, date)

      self.stb = stb
      self.title = title
      self.date = date
      self.provider = provider
      self.rev = rev
      self.view_time = view_time
    end

    def to_s
      [stb, title, date, provider, rev, view_time].join("|")
    end

    protected

    def validate_id(stb, title, date)
      raise Error::InvalidId if([stb, title, date].any?(nil))
    end
  end
end
