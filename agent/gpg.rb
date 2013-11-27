module MCollective
  module Agent
    class Gpg<RPC::Agent

      require 'rubygems'
      require 'gpgme'
      action 'pubkey' do
        key = GPGME::Key.find(:public, request[:key])
        unless key.empty?
          reply[:pubkey] = key.first.export(:armor => true).read
        end
      end

      action 'list' do
        reply[:keys] = []
        keys = GPGME::Key.find(:public)
        keys.each do |k|
          reply[:keys] << {
            :name => k.name,
            :email => k.email,
            :fingerprint => k.fingerprint
          }
        end
      end



    end
  end
end

