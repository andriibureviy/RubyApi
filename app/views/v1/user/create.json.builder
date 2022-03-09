# frozen_string_literal: true

json.data do
  json.user do
    json.call(
      @user,
      :email,
      :password
    )
  end
end
