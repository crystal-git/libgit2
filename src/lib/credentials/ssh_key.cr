module Git::Credentials
  class SshKey < Base
    getter username : String
    getter public_key : String
    getter private_key : String
    getter passphrase : String

    def initialize(@public_key : String, @private_key : String, username : String? = nil, passphrase : String? = nil)
      @username = username || "git"
      @passphrase = passphrase || ""
    end

    @callback : C::CredAcquireCb?
    def callback
      @callback ||= C::CredAcquireCb.new do |out_, url, username_from_url, allowd_types, payload|
        this = Box(CallbackPayload).unbox(payload).credential.as(SshKey)
        return C.cred_ssh_key_new(out_, this.username, this.public_key, this.private_key, this.passphrase)
      end
    end
  end
end
