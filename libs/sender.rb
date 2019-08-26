module EgoSearch

  class Sender
    if Config.slack.kind_of? Hash and
        Config.slack.has_key? 'token' and
        Config.slack.has_key? 'channel'
        Config.slack.has_key? 'username'
        Config.slack.has_key? 'icon_emoji'

      Slack.configure do |config|
        config.token = Config.slack.token
      end

      @@client = Slack::Web::Client.new
      @@client.auth_test
    end

    def self.send(message)
      @@client.chat_postMessage(
        channel: Config.slack.channel,
        text: message,
        username: Config.slack.username,
        icon_emoji: Config.slack.icon_emoji)
    end
  end

end
