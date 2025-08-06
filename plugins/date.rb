# Jekyll 4 compatible date plugin
module Octopress
  module Date

    # Returns a datetime if the input is a string
    def datetime(date)
      if date.class == String
        date = Time.parse(date)
      end
      date
    end

    # Returns an ordinal date eg July 22 2007 -> July 22nd 2007
    def ordinalize(date)
      date = datetime(date)
      "#{date.strftime('%b')} #{ordinal(date.strftime('%e').to_i)}, #{date.strftime('%Y')}"
    end

    # Returns an ordinal number. 13 -> 13th, 21 -> 21st etc.
    def ordinal(number)
      if (11..13).include?(number.to_i % 100)
        "#{number}<span>th</span>"
      else
        case number.to_i % 10
        when 1; "#{number}<span>st</span>"
        when 2; "#{number}<span>nd</span>"
        when 3; "#{number}<span>rd</span>"
        else    "#{number}<span>th</span>"
        end
      end
    end

    # Formats date either as ordinal or by given date format
    # Adds %o as ordinal representation of the day
    def format_date(date, format)
      date = datetime(date)
      if format.nil? || format.empty? || format == "ordinal"
        date_formatted = ordinalize(date)
      else
        date_formatted = date.strftime(format)
        date_formatted.gsub!(/%o/, ordinal(date.strftime('%e').to_i))
      end
      date_formatted
    end
    
    # Returns the date-specific liquid attributes
    def liquid_date_attributes
      return {} unless respond_to?(:site) && site && site.config
      date_format = site.config['date_format']
      date_attributes = {}
      if respond_to?(:data) && data
        date_attributes['date_formatted']    = format_date(data['date'], date_format)    if data.has_key?('date')
        date_attributes['updated_formatted'] = format_date(data['updated'], date_format) if data.has_key?('updated')
      end
      date_attributes
    end

  end
end


module Jekyll

  class Post
    include Octopress::Date

    # Override to_liquid for Jekyll 4 compatibility
    def to_liquid(attrs = nil)
      begin
        base_data = if attrs.nil?
                     super()
                   else
                     super(attrs)
                   end
        base_data.merge(liquid_date_attributes)
      rescue => e
        # Fallback for compatibility - just return basic data without date formatting
        Jekyll.logger.debug "Date plugin fallback: #{e.message}" if defined?(Jekyll.logger)
        if attrs.nil?
          super() rescue {}
        else
          super(attrs) rescue {}
        end
      end
    end
  end

  class Page
    include Octopress::Date

    # Override to_liquid for Jekyll 4 compatibility  
    def to_liquid(attrs = nil)
      begin
        base_data = if attrs.nil?
                     super()
                   else
                     super(attrs)
                   end
        base_data.merge(liquid_date_attributes)
      rescue => e
        # Fallback for compatibility - just return basic data without date formatting
        Jekyll.logger.debug "Date plugin fallback: #{e.message}" if defined?(Jekyll.logger)
        if attrs.nil?
          super() rescue {}
        else
          super(attrs) rescue {}
        end
      end
    end
  end

end