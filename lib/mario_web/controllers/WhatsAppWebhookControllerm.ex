defmodule MarioWeb.WhatsAppWebhookController do
 use MarioWeb, :controller
require IEx
  # alias MyApp.{Repo, Chats, ResendMessage, Bids}
  # alias MyApp.WhatsAppService

  # POST /api/whatsapp/webhook
  def webhook(conn, %{"messages" => messages} = payload) do
     IEx.pry()
     case messages do
      [first_message | _] ->
        process_message(first_message, payload)
        send_resp(conn, 200, "OK")

      _ ->
        send_resp(conn, 400, "Invalid payload")
    end
  end



defp process_message(message, payload) do
  import Ecto.Query
  require IEx
  message_receive_time =
    message["timestamp"]
    |> DateTime.from_unix!()
    |> DateTime.to_naive()

  bid_attrs = %{
    channel_id: payload["channel_id"],
    colud_chat_id: message["chat_id"],
    mobile_no: message["from"],
    name: message["from_name"],
    in_message: message["text"]["body"],
    message_receive_time: message_receive_time,
     message_id: message["id"],
    # Provide default values or actual IDs if available
    group_id: 1,

  }


IEx.pry()
{:ok, bid} =
  %Mario.Models.Bid{}
  |> Mario.Models.Bid.changeset(bid_attrs)
  |> Mario.Repo.insert()

Phoenix.PubSub.broadcast(
  Mario.PubSub,
  "bids",
  {:new_bid, bid}
)


end

end
