class LobController < ApplicationController
  @lob = Lob(api_key: "live_45276d9bcbb1e49e4512926ec100bfe2e6d" )

  def create_address_from_order(order)
    @lob.addresses.create(
      name:           order.name,
      address_line1:  order.address_line1,
      city:           order.city,
      state:          order.state,
      country:        order.country,
      zip:            order.zip)
  end

  def create_object_from_data
    @lob.objects.create(
      name:,
      file:,
      setting_id:)
  end

  def create_custom_postcard_from_data
    @lob.postcards.create(
      name:,
      to:,
      from:,
      front:,
      back:)
  end

  def @lob.postcards.create(
    name:,
    to:,
    from:,
    front:,
    message:)
  end

  def create_job_from_form_data
    @lob.jobs.create(
      name:,
      from:,
      to:,
      objects:)
  end


end