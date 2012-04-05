require 'formula'

class MtrCli < Formula
  url 'ftp://ftp.bitwizard.nl/mtr/mtr-0.82.tar.gz'
  homepage 'http://www.bitwizard.nl/mtr/'
  sha1 'f1319de27324d85898a9df0a293a438bbaaa12b5'

  def install
    # We need to add this because nameserver8_compat.h has been removed in Snow Leopard
    ENV['LIBS'] = "-lresolv"
    args = ["--prefix=#{prefix}", "--disable-debug", "--disable-dependency-tracking", "--without-gtk"]
    system "./configure", *args
    system "make install"
  end

  def caveats
    "Run:\nsudo chmod 4755 /usr/local/sbin/mtr\nsudo chown root /usr/local/sbin/mtr\nto use MTR without being root."
  end
end
