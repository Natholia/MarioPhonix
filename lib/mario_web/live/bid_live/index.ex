defmodule MarioWeb.BidLive.Index do
  use MarioWeb, :live_view

  alias Mario.Bids
  alias Mario.Models.Bid

  @impl true
def mount(_params, session, socket) do
  # Build current_admin from session
  current_admin =
    case session do
      %{"admin_id" => admin_id, "usertype" => usertype} ->
        %{id: admin_id, usertype: usertype}

      _ ->
        %{usertype: "Guest"}
    end

  if connected?(socket), do: Phoenix.PubSub.subscribe(Mario.PubSub, "bids")

  {:ok,
   socket
   |> assign(:current_admin, current_admin)
   |> assign(:page_title, "Bids")
   |> assign(:bids, Bids.list_all()),
   layout: {MarioWeb.Layouts, :admin}}
end


  @impl true
  def handle_info({:new_bid, %Bid{} = bid}, socket) do
    {:noreply, assign(socket, :bids, [bid | socket.assigns.bids])}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="p-5">
      <h2 class="text-2xl font-bold mb-4">Bids</h2>
      <table class="table-auto w-full border">
        <thead>
          <tr class="bg-gray-200">
            <th class="p-2 border">ID</th>
            <th class="p-2 border">Name</th>
            <th class="p-2 border">Mobile</th>
            <th class="p-2 border">Message</th>
            <th class="p-2 border">Received</th>
          </tr>
        </thead>
        <tbody>
          <%= for bid <- @bids do %>
            <tr class="border-b hover:bg-gray-50">
              <td class="p-2 border"><%= bid.id %></td>
              <td class="p-2 border"><%= bid.name %></td>
              <td class="p-2 border"><%= bid.mobile_no %></td>
              <td class="p-2 border"><%= bid.in_message %></td>
              <td class="p-2 border"><%= bid.message_receive_time %></td>
            </tr>
          <% end %>
        </tbody>
      </table>
    </div>
    """
  end
end
