module DatetimeHelper

  def DatetimeHelper.convertDateToAge(date)
    current_time = Time.now.utc.to_s;
    article_time = DateTime.strptime(date).to_s;
    seconds = Time.parse(current_time) - Time.parse(article_time);
    hours = (seconds / 3600).round
    days = (hours / 24).round
    weeks = (days / 7).round
    if weeks > 1
      return weeks.to_s + " weeks ago"
    elsif weeks == 1
      return weeks.to_s + " week ago"
    elsif days > 1
      return days.to_s + " days ago"
    elsif days == 1
      return days.to_s + " day ago"
    elsif hours > 1
      return hours.to_s + " hours ago"
    elsif hours == 1
      return hours.to_s + " hour ago"
    else
      return "Less than an hour ago"
    end
  end
end