require './lib/telegram_actions'

namespace :telegram do
  desc 'Bot actions list'
  task :actions => :environment do |_t, args|
    puts "Available bot actions:\n"
    puts
    TelegramActions.new.perform.each_pair do |action, comment|
      puts [ "/#{action}",comment ].compact.join(' - ')
    end
  end
end
