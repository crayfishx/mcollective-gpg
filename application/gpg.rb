module MCollective
  class Application::Gpg<Application
    require 'gpgme'
    description "MCollective GPG utilities."
    usage <<-EOF
    mco gpg import dir=/path key=PATTERN
    mco gpg list
    EOF

    option    	:dir,
                :arguments   => ["--dir PATH"],
                :description => "Containing folder for GPG import",
                :required    => false

    option      :key,
                :arguments   => ["--key KEY"],
                :description => "Name of the key to look for",
                :required    => false


    def post_option_parser(configuration)
      configuration[:action]=ARGV.shift
    end

    def main
      if configuration[:action] == "import"
        import_keys
      end
      if configuration[:action] == "list"
        list_keys
      end
    end

    def list_keys
      mco = rpcclient('gpg')
      if configuration[:key]
        res = mco.send('list', :key => configuration[:key])
      else
        res = mco.send('list')
      end
      host_w = res.max { |a,b| a[:sender].length <=> b[:sender].length }[:sender].length
      name_w=10
      res.each do |result|
        result[:data][:keys].each do |k|
          puts "%-#{host_w}s %-41s %-#{name_w}s %s" % [result[:sender],k[:fingerprint],k[:name],k[:email]]
        end
      end
    end

    def import_keys
      mco = rpcclient('gpg')
      res = mco.send('pubkey', :key => configuration[:key])
      if configuration[:dir]
        ENV['GNUPGHOME'] = configuration[:dir]
      end
      ctx = GPGME::Ctx.new
      res.each do |result|
        key = GPGME::Data.new(result[:data][:pubkey])
        ctx.import_keys(key)
      end
      ctx.each_key do |k|
        puts " + #{k.fingerprint} #{k.email}"
      end
    end
  end
end
