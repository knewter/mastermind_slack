defmodule MastermindSlack.Bot.Handler do
  @bios """
  Oh you mean these? #{System.get_env("BIOS_URL")}
  """

  def handle("show me those bios though", channel, slack=%Slack.State{}, state) do
    Slack.send_message(@bios, channel, slack)
  end

  def handle(message, _channel, slack=%Slack.State{}, state) do
    IO.puts message

    {:ok, state}
  end

  def handle(_message, _channel, _slack, state) do
    {:ok, state}
  end
end
