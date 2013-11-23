require 'cinch'
require_relative 'plugins/weather'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = 'irc.rizon.net'
    c.channels = ['#game-deception']
    c.nick = 'Rubert'
    c.user = 'Rubert'
    c.realname = 'Rubert The Robert'
    c.plugins.prefix = '@'
    c.plugins.plugins = [Weather]
  end
end

bot.start