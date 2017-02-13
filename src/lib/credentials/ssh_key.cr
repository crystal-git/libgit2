module Git::Credentials
  class SshKey < Base
    getter username : String
    @public_key : String?
    @private_key : String?
    getter passphrase : String

    def initialize(username : String? = nil, @public_key : String? = nil, @private_key : String? = nil, passphrase : String? = nil)
      @username = username || "git"
      @passphrase = passphrase || ""
    end

    def public_key?
      @public_key || if home = ENV["HOME"]?
        "#{home}/.ssh/id_rsa.pub"
      end
    end

    def private_key?
      @private_key || if home = ENV["HOME"]?
        "#{home}/.ssh/id_rsa"
      end
    end

    @callback : C::CredAcquireCb?
    def callback
      @callback ||= C::CredAcquireCb.new do |out_, url, username_from_url, allowed_types, payload|
        this = Box(CallbackPayload).unbox(payload).credential.as(SshKey)
        public_key = this.public_key?
        private_key = this.private_key?
        return C::Euser unless public_key
        return C::Euser unless private_key
        return C.cred_ssh_key_new(out_, this.username, public_key, private_key, this.passphrase)
      end
    end
  end
end
