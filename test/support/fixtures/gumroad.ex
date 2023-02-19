defmodule GumHub.Fixtures.Gumroad do
  def successful_verify_license(uses) do
    # Data for fixture taken from https://app.gumroad.com/api#licenses
    %Tesla.Env{
      status: 200,
      body: %{
        "success" => true,
        "uses" => uses,
        "purchase" => %{
          "seller_id" => "kL0psVL2admJSYRNs-OCMg==",
          "product_id" => "32-nPAicqbLj8B_WswVlMw==",
          "product_name" => "licenses demo product",
          "permalink" => "QMGY",
          "product_permalink" => "https://sahil.gumroad.com/l/pencil",
          "email" => "customer@example.com",
          "price" => 0,
          "gumroad_fee" => 0,
          "currency" => "usd",
          "quantity" => 1,
          "discover_fee_charged" => false,
          "can_contact" => true,
          "referrer" => "direct",
          "card" => %{
            "visual" => nil,
            "type" => nil
          },
          "order_number" => 524_459_935,
          "sale_id" => "FO8TXN-dbxYaBdahG97Y-Q==",
          "sale_timestamp" => "2021-01-05T19:38:56Z",
          "purchaser_id" => "5550321502811",
          "subscription_id" => "GDzW4_aBdQc-o7Gbjng7lw==",
          "variants" => "",
          "license_key" => "85DB562A-C11D4B06-A2335A6B-8C079166",
          "is_multiseat_license" => false,
          "ip_country" => "United States",
          "recurrence" => "monthly",
          "is_gift_receiver_purchase" => false,
          "refunded" => false,
          "disputed" => false,
          "dispute_won" => false,
          "id" => "FO8TXN-dvaYbBbahG97a-Q==",
          "created_at" => "2021-01-05T19:38:56Z",
          "custom_fields" => [],
          # purchase was refunded, non-subscription product only
          "chargebacked" => false,
          # subscription was ended, subscription product only
          "subscription_ended_at" => nil,
          # subscription was cancelled, subscription product only
          "subscription_cancelled_at" => nil,
          # we were unable to charge the subscriber's card
          "subscription_failed_at" => nil
        }
      }
    }
  end

  def license_not_foud() do
    %Tesla.Env{
      status: 404,
      body: %{
        "message" => "That license does not exist for the provided product.",
        "success" => false
      }
    }
  end
end
