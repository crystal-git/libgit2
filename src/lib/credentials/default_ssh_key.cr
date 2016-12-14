module Git::Credentials
  class DefaultSshKey < Base
    @@instance = DefaultSshKey.new
    def self.instance
      @@instance
    end

    getter! username : String?
    getter! public_key : String?
    getter! private_key : String?
    getter! passphrase : String?

    def initialize
      if home = ENV["HOME"]?
        ssh_home = "#{home}/.ssh"
        @username = "git"
        @public_key = "#{ssh_home}/id_rsa.pub"
        @private_key = "#{ssh_home}/id_rsa"
        @passphrase = ""
      end
    end

    @callback : C::CredAcquireCb?
    def callback
      @callback ||= C::CredAcquireCb.new do |out_, url, username_from_url, allowd_types, payload|
        this = Box(CallbackPayload).unbox(payload).credential.as(DefaultSshKey)
        return C::Euser unless this.username?
        return C.cred_ssh_key_new(out_, this.username, this.public_key, this.private_key, this.passphrase)
      end
    end
  end
end
