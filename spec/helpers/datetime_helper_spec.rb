require 'rails_helper'

RSpec.describe DatetimeHelper, type: :helper do

  include ActiveSupport::Testing::TimeHelpers

  describe "convertDateToAge" do
    it "returns the time since a given date" do
      travel_to Time.utc(2019, 02, 27, 00, 00, 00)

      # set up varying times
      less_than_hour_ago = DatetimeHelper.convertDateToAge("2019-02-26T23:45:00Z")
      hour_ago = DatetimeHelper.convertDateToAge("2019-02-26T22:45:00Z")
      hours_ago = DatetimeHelper.convertDateToAge("2019-02-26T20:45:00Z")
      day_ago = DatetimeHelper.convertDateToAge("2019-02-25T20:45:00Z")
      days_ago = DatetimeHelper.convertDateToAge("2019-02-22T20:45:00Z")
      week_ago = DatetimeHelper.convertDateToAge("2019-02-16T20:45:00Z")
      weeks_ago = DatetimeHelper.convertDateToAge("2019-02-06T20:45:00Z")

      expect(less_than_hour_ago).to eq("Less than an hour ago")
      expect(hour_ago).to eq("1 hour ago")
      expect(hours_ago).to eq("3 hours ago")
      expect(day_ago).to eq("1 day ago")
      expect(days_ago).to eq("4 days ago")
      expect(week_ago).to eq("1 week ago")
      expect(weeks_ago).to eq("2 weeks ago")

    end
  end
end