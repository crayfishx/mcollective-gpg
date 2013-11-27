mcollective-gpg
===============

MCollective application to manage and query GPG keys

This application is still largely experimental - the primary purpose was to create an agent that could query specific GPG keys across the infrastructure, return the public keys and build a keyring on the client. I wrote it to make it easy to query a bunch of Puppet Masters for the hiera public key and build a keyring for use with hiera-gpg but hopefully I'll get around to making it a more generic toolstack for more uses.. Eg:

    mco gpg import dir=/etc/puppet/keyrings key=hiera

You can also use this application to query all GPG keys for root

    mco gpg list
    mco gpg list hiera


