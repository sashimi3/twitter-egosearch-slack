module EgoSearch

  class Sender
    if Config.slack.kind_of? Hash and
        Config.slack.has_key? 'token' and
        Config.slack.has_key? 'channel'

      Slack.configure do |config|
        config.token = Config.slack.token
      end

      @@client = Slack::Web::Client.new
      @@client.auth_test
    end

    def self.send(message)
      @@client.chat_postMessage(channel: Config.slack.channel, text: message, as_user: true)
    end
  end

end
