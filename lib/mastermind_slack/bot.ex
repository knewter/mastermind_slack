defmodule MastermindSlack.Bot do
  use Slack

  def start_link(initial_state) do
    token = System.get_env("SLACK_BOT_API_TOKEN")
    if token do
      Slack.start_link(__MODULE__, System.get_env("SLACK_BOT_API_TOKEN"), initial_state)
    else
      exit "SLACK_BOT_API_TOKEN was not found, did you set it?"
    end
  end

  def init(initial_state, slack) do
    IO.puts "Connected as #{slack.me.name}"
    {:ok, initial_state}
  end

  def handle_message({:type, "hello", response}, slack, state) do
    IO.puts "Available channels: #{inspect Slack.State.channels(slack)}"
    {:ok, state}
  end

  def handle_message({:type, "message", response}, slack, state) do
    IO.puts "message"
    IO.inspect response

    IO.inspect slack
    IO.inspect state
    {:ok, state} = MastermindSlack.Bot.Handler.handle(response.text, response.channel, slack, state)

    {:ok, state}
  end

  def handle_message({:type, type, _response}, _slack, state) do
    IO.puts "some other type"
    {:ok, state}
  end
end
