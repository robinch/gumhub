defmodule GumHub.GumroadTest do
  use ExUnit.Case

  import ExUnit.CaptureLog

  alias GumHub.Gumroad
  alias GumHub.Fixtures

  test "success: verified" do
    Tesla.Mock.mock(fn
      %{method: :post} ->
        Fixtures.Gumroad.successful_verify_license(1)
    end)

    assert :ok == Gumroad.verify_license("product_id", "license_id")
  end

  test "error: too many uses" do
    Tesla.Mock.mock(fn
      %{method: :post} ->
        Fixtures.Gumroad.successful_verify_license(2)
    end)

    log =
      capture_log(fn ->
        assert {:error, :too_many_uses} == Gumroad.verify_license("product_id", "license_id")
      end)

    assert log =~ "[error] Too many uses (2) on license (license_id)"
  end

  test "error: not verified" do
    Tesla.Mock.mock(fn
      %{method: :post} ->
        Fixtures.Gumroad.license_not_foud()
    end)

    log =
      capture_log(fn ->
        assert {:error, :license_not_found} = Gumroad.verify_license("product_id", "license_id")
      end)

    assert log =~ "[error] License (license_id) not found"
  end
end
