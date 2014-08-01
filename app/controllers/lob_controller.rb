class LobController < ApplicationController
  @lob = Lob(api_key: ENV['LOB_API_KEY'] )

  def create_address_from_order(order)
    @lob.addresses.create(
      name:           order.name,
      address_line1:  order.address_line1,
      city:           order.city,
      state:          order.state,
      country:        order.country,
      zip:            order.zip)
  end

  def create_object_from_data(lob_object)
    @lob.objects.create(
      name:       lob_object.name,
      file:       lob_object.file_location,
      setting_id: lob_object.setting_id)
  end

  def create_custom_postcard_from_data(data)
    @lob.postcards.create(
      name:     data.job_name,
      to:       data.receiver,
      from:     current_user,
      front:    data.front_file,
      back:     data.back_file)
  end

  def create_message_postcard_from_data(data)
    @lob.postcards.create(
      name:     data.job_name,
      to:       data.receiver,
      from:     data.sender,
      message:  data.message,
      back:     data.back_file)
  end

  def create_job_from_form_data(data)
    @lob.jobs.create(
      name:     data.job_name,
      from:     data.sender,
      to:       data.receiver,
      objects:  data.objects)
  end
end