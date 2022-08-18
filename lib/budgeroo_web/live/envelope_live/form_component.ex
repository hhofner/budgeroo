defmodule BudgerooWeb.EnvelopeLive.FormComponent do
  use BudgerooWeb, :live_component

  alias Budgeroo.Budget

  @impl true
  def update(%{envelope: envelope} = assigns, socket) do
    changeset = Budget.change_envelope(envelope)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
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
    save_envelope(socket, socket.assigns.action, envelope_params)
  end

  defp save_envelope(socket, :edit, envelope_params) do
    case Budget.update_envelope(socket.assigns.envelope, envelope_params) do
      {:ok, _envelope} ->
        {:noreply,
         socket
         |> put_flash(:info, "Envelope updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_envelope(socket, :new, envelope_params) do
    case Budget.create_envelope(envelope_params) do
      {:ok, _envelope} ->
        {:noreply,
         socket
         |> put_flash(:info, "Envelope created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
