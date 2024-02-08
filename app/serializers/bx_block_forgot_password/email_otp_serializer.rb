module BxBlockForgotPassword
  class EmailOtpSerializer < BuilderBase::BaseSerializer
    attributes :email, :created_at
    attributes :pin
  end
end
