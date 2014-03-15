require "formula"

# Documentation: https://github.com/Homebrew/homebrew/wiki/Formula-Cookbook
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Qwtplot3d < Formula
  homepage "http://qwtplot3d.sourceforge.net"
  url "http://downloads.sourceforge.net/project/qwtplot3d/qwtplot3d/0.2.7/qwtplot3d-0.2.7.tgz"
  sha1 "4463fafb8420a91825e165da7a296aaabd70abea"

  depends_on :x11
  depends_on 'qt'

  def patches
    "https://gist.githubusercontent.com/sic/9519552/raw/d4ad06dddf7bc3cbd9075c208bb9116ca3b3a2b8/gistfile1.diff"
  end

  def install
    
    inreplace 'qwtplot3d.pro' do |s|
      s.gsub! /^\s*DESTDIR\s*=(.*)$/, "DESTDIR=#{prefix}"
    end

    # TODO: add INCLUDEPATH += /opt/X11/include to qwtplot3d.pro


    # TODO: Apply patch


    args = ['-config', 'release', '-spec']
    # On Mavericks we want to target libc++, this requires a unsupported/macx-clang-libc++ flag
    if ENV.compiler == :clang and MacOS.version >= :mavericks
      args << "unsupported/macx-clang-libc++"
    else
      args << "macx-g++"
    end
    system 'qmake', *args
    system "make"
    system "make", "install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test qwtplot3d`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
