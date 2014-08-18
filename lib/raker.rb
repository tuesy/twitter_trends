# for use in Rake tasks
class Raker
  class << self
    # used in tests
    # e.g. Raker.run('scrapers:daily[true]')
    def run(task_with_args)
      raise 'ERROR: invalid task a arguments' unless task_with_args.match(/([^\[]+)(\[.*\])?/)
      Rake::Task[$1.strip].reenable
      Rake.application.invoke_task task_with_args
    end
    # email exceptions and time the execution
    # 'max_time' - alert when completed by took too long
    # environment variable NO_EMAILS to something if you want to skip email sending
    def monitor(task, args, options={}, &block)
      options = {
        max_time: 10.minutes,
        debug: false
        }.merge(options)
      begin
        start_time = Time.zone.now
        p 'Starting', task
        yield
        elapsed_time = Time.zone.now - start_time
        p "Completed in #{elapsed_time.round} seconds"
        if options[:max_time] && elapsed_time > options[:max_time]
          raise "This completed but took too long! (#{elapsed_time} seconds)"
        end
      rescue Exception => e
        # send emails even in development
        ActionMailer::Base.perform_deliveries = true unless ENV['NO_EMAILS']
        if options[:debug]
          raise e
        else
          mail = UserMailer.exception(task, args, e)
          p "Emailing #{mail.to.first} with subject '#{mail.subject}'"
          mail.deliver
        end
      end
    end
=begin
Examples:
Raker.banner 'starting'
************************************************************
2014-06-04 14:06:11 -0700 - starting
************************************************************
=end
    def banner message, klass=nil
      puts '*' * 60
      self.p message,klass
      puts '*' * 60
    end
=begin
Examples:
Raker.p 'starting'
2014-06-04 14:05:12 -0700 - starting
Raker.p 'starting', Hiver
=> 2014-06-04 14:05:12 -0700 - Hiver - starting
=end
    def p(message, klass=nil)
      pp message if message.kind_of?(Hash)
      parts = [Time.zone.now]
      parts << klass.name if klass
      parts << message
      puts parts.map(&:to_s).join(' - ')
    end
  end
end
