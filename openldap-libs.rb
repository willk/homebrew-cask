require 'formula'

class OpenldapLibs < Formula
  url 'ftp://ftp.openldap.org/pub/OpenLDAP/openldap-stable/openldap-stable-20120311.tgz'
  homepage 'http://www.openldap.org/'
  md5 '4f210937cf87e3467a536dd3fed1b8b4'
  version = '2.4.30'

  def install
    system "./configure", "--disable-debug", "--prefix=#{prefix}",
                          "--disable-slapd", "--disable-slurpd"

    # empty Makefiles to prevent unnecessary installation attempts
    makefile = "all:\ninstall:\n"
    unwanted_paths = ['clients', 'servers', 'tests', 'doc']
    unwanted_paths.each do |upath|
      File.open(Dir.getwd + '/' + upath + '/Makefile', 'w') {|f| f.write(makefile)}
    end

    system "make install"
    File.rename("#{prefix}/etc/openldap/ldap.conf", "#{prefix}/etc/openldap/ldap.conf.backup")
    File.symlink('/etc/openldap/ldap.conf', "#{prefix}/etc/openldap/ldap.conf")
  end
end
