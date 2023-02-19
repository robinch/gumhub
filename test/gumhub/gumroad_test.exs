defmodule GumHub.GumroadTest do
  use ExUnit.Case

  alias GumHub.Gumroad
  alias GumHub.Fixtures

  test "success: verified" do
    Tesla.Mock.mock(fn
      %{method: :post} ->
        Fixtures.Gumroad.successful_verify_license(0)
    end)

    assert :ok == Gumroad.verify_license("product_id", "license_id")
  end

  test "error: too many uses" do
    Tesla.Mock.mock(fn
      %{method: :post} ->
        Fixtures.Gumroad.successful_verify_license(2)
    end)

    assert {:error, :too_many_uses} == Gumroad.verify_license("product_id", "license_id")
  end

  test "error: not verified" do
    Tesla.Mock.mock(fn
      %{method: :post} ->
        Fixtures.Gumroad.license_not_foud()
    end)

    assert {:error, :license_not_found} = Gumroad.verify_license("product_id", "license_id")
  end
end
