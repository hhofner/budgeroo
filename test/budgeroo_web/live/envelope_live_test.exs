defmodule BudgerooWeb.EnvelopeLiveTest do
  use BudgerooWeb.ConnCase

  import Phoenix.LiveViewTest
  import Budgeroo.BudgetFixtures

  @create_attrs %{amount: 42, goal: 42, group: "some group", name: "some name"}
  @update_attrs %{amount: 43, goal: 43, group: "some updated group", name: "some updated name"}
  @invalid_attrs %{amount: nil, goal: nil, group: nil, name: nil}

  defp create_envelope(_) do
    envelope = envelope_fixture()
    %{envelope: envelope}
  end

  describe "Index" do
    setup [:create_envelope]

    test "lists all envelopes", %{conn: conn, envelope: envelope} do
      {:ok, _index_live, html} = live(conn, Routes.envelope_index_path(conn, :index))

      assert html =~ "Listing Envelopes"
      assert html =~ envelope.group
    end

    test "saves new envelope", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.envelope_index_path(conn, :index))

      assert index_live |> element("a", "New Envelope") |> render_click() =~
               "New Envelope"

      assert_patch(index_live, Routes.envelope_index_path(conn, :new))

      assert index_live
             |> form("#envelope-form", envelope: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#envelope-form", envelope: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.envelope_index_path(conn, :index))

      assert html =~ "Envelope created successfully"
      assert html =~ "some group"
    end

    test "updates envelope in listing", %{conn: conn, envelope: envelope} do
      {:ok, index_live, _html} = live(conn, Routes.envelope_index_path(conn, :index))

      assert index_live |> element("#envelope-#{envelope.id} a", "Edit") |> render_click() =~
               "Edit Envelope"

      assert_patch(index_live, Routes.envelope_index_path(conn, :edit, envelope))

      assert index_live
             |> form("#envelope-form", envelope: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#envelope-form", envelope: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.envelope_index_path(conn, :index))

      assert html =~ "Envelope updated successfully"
      assert html =~ "some updated group"
    end

    test "deletes envelope in listing", %{conn: conn, envelope: envelope} do
      {:ok, index_live, _html} = live(conn, Routes.envelope_index_path(conn, :index))

      assert index_live |> element("#envelope-#{envelope.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#envelope-#{envelope.id}")
    end
  end

  describe "Show" do
    setup [:create_envelope]

    test "displays envelope", %{conn: conn, envelope: envelope} do
      {:ok, _show_live, html} = live(conn, Routes.envelope_show_path(conn, :show, envelope))

      assert html =~ "Show Envelope"
      assert html =~ envelope.group
    end

    test "updates envelope within modal", %{conn: conn, envelope: envelope} do
      {:ok, show_live, _html} = live(conn, Routes.envelope_show_path(conn, :show, envelope))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Envelope"

      assert_patch(show_live, Routes.envelope_show_path(conn, :edit, envelope))

      assert show_live
             |> form("#envelope-form", envelope: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#envelope-form", envelope: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.envelope_show_path(conn, :show, envelope))

      assert html =~ "Envelope updated successfully"
      assert html =~ "some updated group"
    end
  end
end
