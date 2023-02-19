defmodule GumHubWeb.GumroadControllerTest do
  use GumHubWeb.ConnCase

  import Hammox

  setup :verify_on_exit!

  test "POST /gumroad/ping", %{conn: conn} do
    MockGumHub
    |> expect(:give_verified_user_github_repo_access, fn license_key, github_username ->
      assert license_key == "license_key_123"
      assert github_username == "github_username_123"

      :ok
    end)

    body = %{
      "GitHub Username" => "github_username_123",
      "can_contact" => "true",
      "card" => %{
        "bin" => "",
        "expiry_month" => "",
        "expiry_year" => "",
        "type" => "",
        "visual" => ""
      },
      "currency" => "usd",
      "custom_fields" => %{"GitHub Username" => "github_username_123"},
      "discover_fee_charged" => "false",
      "dispute_won" => "false",
      "disputed" => "false",
      "email" => "test@example.com",
      "gumroad_fee" => "0",
      "ip_country" => "Sweden",
      "is_gift_receiver_purchase" => "false",
      "license_key" => "license_key_123",
      "order_number" => "134567",
      "permalink" => "gnudi",
      "price" => "0",
      "product_id" => "porduct_id_123",
      "product_name" => "Test Product",
      "product_permalink" => "https://...",
      "purchaser_id" => "1234567",
      "quantity" => "1",
      "referrer" => "direct",
      "refunded" => "false",
      "resource_name" => "sale",
      "retry_count" => "2",
      "sale_id" => "sale_Id_123",
      "sale_timestamp" => "2023-02-19T15:51:43Z",
      "seller_id" => "seller_id_123",
      "short_product_id" => "gnudi",
      "test" => "true"
    }

    conn = post(conn, ~p"/gumroad/ping", body)

    assert response(conn, 200) == "ok"
  end
end
