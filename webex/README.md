# Run Cisco Webex on 64-bit Ubuntu 16.04

**With Audio and Screen Sharing Enabled**

Source: https://gist.github.com/mshkrebtan

### Enable support for 32-bit executables

Add the `i386` architecture to the list of `dpkg` architectures 
and install the libraries required to execute ELF-32 executables:

~~~
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386
sudo apt-get install libgtk-3-0:i386 libasound2:i386 libdbus-glib-1-2:i386 libxt6:i386
sudo apt-get install libxtst6:i386 libcanberra-gtk-module:i386 libcanberra-gtk3-module:i386
sudo apt-get install libpangoxft-1.0-0:i386 libxft2:i386 libpangox-1.0-0:i386
sudo apt-get install libxmu6:i386 libxv1:i386 libasound2-plugins:i386
sudo apt-get install lib32z1 lib32ncurses5 # Audio Fix

sudo apt-get install topmenu-gtk3:i386
~~~

### Install Firefox 52 ESR (32-bit)

Beginning with Firefox 52 (released March 2017), plug-in support is limited to
Adobe Flash, and drops support for NPAPI, impacting plugins for Java,
Silverlight, and other similar NPAPI based plugins. Hence you need the ESR
release. You can read more on that here:
https://www.java.com/en/download/help/firefox_java.xml

Download Firefox ESR for Linux (32-bit) from
[here](https://www.mozilla.org/en-US/firefox/organizations/all/).

Unpack it to somewhere, for example to `/opt/webex/`:

~~~
sudo mkdir -p /opt/webex/
sudo tar -xjvf firefox*esr*.tar.bz2 -C /opt/webex/
~~~

### Install 32-bit JRE

Download Oracle JRE for Linux (a tar.gz archive for x86 architecture) from
[here](http://www.oracle.com/technetwork/java/javase/downloads/jre8-downloads-2133155.html).

Unpack it to `/opt/webex/`:

~~~
sudo tar -xzvf jre*linux-i586.tar.gz -C /opt/webex/
sudo mv /opt/webex/jre* /opt/webex/jre
~~~

### Enable Java support in Firefox

Create symbolic links for the Java browser plugin libraries:

~~~
sudo mkdir /opt/webex/firefox/plugins/
ln -s \
    /opt/webex/jre/lib/i386/libawt.so \
    /opt/webex/jre/lib/i386/libjawt.so \
    /opt/webex/jre/lib/i386/libnpjp2.so \
    /opt/webex/firefox/plugins
~~~

### Start a Webex session

Launch the script and join a Webex session.

If webex.com sends you a `jnlp` file and Firefox asks what to do with it, just
download it. Further, in the Firefox Preferences > Applications, set the action
for JNLP files: they should be opened with `javaws` (Java Web Start) which can
be found here:

~~~
/opt/webex/jre/bin/javaws
~~~

### (Optional) Install the missing libraries required by Webex

Find out what required libraries are be missing (note that the session number
may be different):

~~~
ldd ~/.webex/T30_MC/*.so | grep "not found"
~~~

You can use http://packages.ubuntu.com/ to find out which packages contain the
libraries.

It is OK to have `libjawt.so` being not found.