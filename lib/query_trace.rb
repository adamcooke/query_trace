module QueryTrace
  def self.append_features(klass)
    super
    klass.class_eval do
      unless method_defined?(:log_info_without_trace)
        alias_method :log_info_without_trace, :log_info
        alias_method :log_info, :log_info_with_trace
      end
    end
  end
  
  def log_info_with_trace(sql, name, runtime)
    log_info_without_trace(sql, name, runtime)
    
    return unless @logger and @logger.debug?
    return if / Columns$/ =~ name

    trace = clean_trace(caller[2..-1])
    @logger.debug(format_trace(trace))
  end
  
  def format_trace(trace)
    if ActiveRecord::Base.colorize_logging
      trace.collect{|t| "    \e[44;37m#{t}\e[0m\n\n"}.join("\n")
    else
      trace.join("\n    ")
    end
  end
  
  VENDOR_RAILS_REGEXP = %r(([\\/:])vendor\1(rails|rubygems|gems)\1)
  def clean_trace(trace)
    return trace unless defined?(RAILS_ROOT)
    trace.select{|t| /#{Regexp.escape(File.expand_path(RAILS_ROOT))}/ =~ t}.reject{|t| VENDOR_RAILS_REGEXP =~ t}.collect{|t| t.gsub(RAILS_ROOT + '/', '')}[0,1]
  end
end
