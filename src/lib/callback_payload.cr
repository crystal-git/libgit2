module Git
  class CallbackPayload
    property! remote : Remote
    property! credential : Credentials::Base

    def self.box
      pl = new
      yield pl, Box.box(pl)
    end
  end
end
