# frozen_string_literal: true

require "openai"

module Ai
  class CommentGenerator
    DEFAULT_MODEL = "gpt-4o-mini"

    SYSTEM_INSTRUCTIONS = <<~TEXT.strip
      You are a helpful assistant that suggests comment text. Reply with only the comment content, no meta-commentary or quotes.
    TEXT

    class << self
      def generate(chat_history)
        messages = build_messages(chat_history)
        response = client.chat(parameters: { model: DEFAULT_MODEL, messages: messages })
        extract_assistant_content(response)
      end

      private

      def client
        api_key = ENV["OPENAI_API_KEY"]
        raise ArgumentError, "OPENAI_API_KEY is not set" if api_key.blank?

        @client ||= OpenAI::Client.new(access_token: api_key)
      end

      def build_messages(chat_history)
        system_message = { role: "system", content: SYSTEM_INSTRUCTIONS }
        history = chat_history.map { |m| m.transform_keys(&:to_s) }
        [system_message] + history
      end

      def extract_assistant_content(response)
        response.dig("choices", 0, "message", "content")&.strip.to_s
      end
    end
  end
end
