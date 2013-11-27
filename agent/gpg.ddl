metadata    :name         => "gpg",
            :description  => "A set of tools to manage GPG keys",
            :author       => "Craig Dunn",
            :license      => "Apache 2.0",
            :version      => "0.0.1",
            :url          => "http://github.com/crayfishx/mco-gpg",
            :timeout      => 60

action "pubkey", :description => "Return a GPG Public Key" do
    input :key,
          :prompt       => "Name of the key",
          :description  => "The name of the private key to search",
          :type         => :string,
          :validation   => :string,
          :optional     => :false,
          :maxlength    => 50

    output  :pubkey,
            :description  =>  "ASCII armoured public key",
            :display_as   =>  "GPG PubKey"
end


action "list", :description => "Return a GPG Public Key" do
    input :key,
          :prompt       => "Name of the key",
          :description  => "The name of the private key to search",
          :type         => :string,
          :validation   => :string,
          :optional     => :true,
          :maxlength    => 50

    output  :keys,
            :description  =>  "GPG Keys",
            :display_as   =>  "Keys"

end


