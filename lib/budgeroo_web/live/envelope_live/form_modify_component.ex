defmodule BudgerooWeb.EnvelopeLive.FormModifyComponent do
  use BudgerooWeb, :live_component
  alias Budgeroo.Budget

  @impl true
  def update(%{envelope: envelope} = assigns, socket) do
    changeset = Budget.change_envelope(envelope)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:other_envelopes, Enum.map(Budget.list_envelopes(), fn e -> {e.name, e.id} end))}
  end

  @impl true
  def handle_event("validate", %{"envelope" => envelope_params}, socket) do
    changeset =
      socket.assigns.envelope
      |> Budget.change_envelope(envelope_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"envelope" => envelope_params}, socket) do
    case Budget.update_envelope(socket.assigns.envelope, %{
           "amount" =>
             String.to_integer(envelope_params["to_add"]) + socket.assigns.envelope.amount
         }) do
      {:ok, _envelope} ->
        {:noreply,
         socket
         |> put_flash(:info, "Envelope updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
