module Tdb
  module Error
    class InvalidId < StandardError; end
  end

  class Record
    attr_accessor :stb, :title, :date, :provider, :rev, :view_time

    # required params - stb, title, date
    def initialize(args)
      if args["record_text"]
        self.stb, self.title, self.provider, self.date, self.rev, self.view_time = args["record_text"].split("|")
      else
        self.stb = args["stb"]
        self.title = args["title"]
        self.date = args["date"]
        self.provider = args["provider"]
        self.rev = args["rev"]
        self.view_time = args["view_time"]
      end

      validate_id(self.stb, self.title, self.date)
    end

    def id
      [self.stb, self.title, self.date].join
    end

    # TODO escape strings
    def to_s
      [stb, title, provider, date, rev, view_time].join("|")
    end

    protected

    def validate_id(stb, title, date)
      raise Error::InvalidId if([stb, title, date].any?(nil))
    end
  end
end
