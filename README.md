# Linuxbrew

Linuxbrew is a fork of [Homebrew](http://brew.sh), the Mac OS package manager, for Linux.

Features, usage and installation instructions are [summarised on the homepage](http://brew.sh/linuxbrew/).

Install Linuxbrew (tl;dr)
-------------------------

Paste at a Terminal prompt:

``` sh
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
```

See [Dependencies](#dependencies) and [Installation](#installation) below for more details.

Features
--------

+ Can install software to a home directory and so does not require sudo
+ Install software not packaged by the native distribution
+ Install up-to-date versions of software when the native distribution is old
+ Use the same package manager to manage both your Mac and Linux machines

Dependencies
------------

* **Ruby** 1.8.6 or newer
+ **GCC** 4.2 or newer
* **Git** 1.7.12.4 or newer
+ **Linux** 2.6.16 or newer
+ **64-bit x86** or **32-bit ARM** platform

Paste at a Terminal prompt:

### Debian or Ubuntu

```sh
sudo apt-get install build-essential curl git m4 python-setuptools ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev
```

### Fedora, CentOS or Red Hat

```sh
sudo yum groupinstall 'Development Tools' && sudo yum install curl git irb m4 python-setuptools ruby texinfo bzip2-devel curl-devel expat-devel ncurses-devel zlib-devel
```

### 32-bit x86 platforms

Linuxbrew does not currently support 32-bit x86 platforms. It would be possible for Linuxbrew to work on 32-bit x86 platforms with some effort. Pull requests would be welcome if someone were to volunteer to maintain the 32-bit x86 support.

Installation
------------

Paste at a Terminal prompt:

``` sh
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
```

Or if you prefer:

```sh
git clone https://github.com/Homebrew/linuxbrew.git ~/.linuxbrew
```

Add to your `.bashrc` or `.zshrc`:

```sh
export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
```

You're done!

```sh
brew install $WHATEVER_YOU_WANT
```

## What Packages Are Available?
1. Type `brew search` for a list.
2. Or visit [braumeister.org](http://braumeister.org) to browse packages online.
3. Or use `brew search --desc` to browse packages from the command line.

## More Documentation
`brew help`, `man brew` or check [our documentation](https://github.com/Homebrew/linuxbrew/tree/master/share/doc/homebrew#readme).

## Troubleshooting
First, please run `brew update` and `brew doctor`.

Second, read the [Troubleshooting Checklist](https://github.com/Homebrew/linuxbrew/blob/master/share/doc/homebrew/Troubleshooting.md#troubleshooting).

**If you don't read these it will take us far longer to help you with your problem.**

## Something broke!

Many of the Homebrew formulae work on either Mac or Linux without changes, but some formulae will need to be adapted for Linux. If a formula doesn't work, [open an issue on GitHub](https://github.com/Homebrew/linuxbrew/issues) or, even better, submit a pull request.

## Security
Please report security issues to security@brew.sh.

This is our PGP key which is valid until June 17, 2016.
* Key ID: `0xE33A3D3CCE59E297`
* Fingerprint: `C657 8F76 2E23 441E C879  EC5C E33A 3D3C CE59 E297`
* Full key: https://keybase.io/homebrew/key.asc

## Who Are You?
Linuxbrew is maintained by [Shaun Jackman](https://github.com/sjackman).

Homebrew's current maintainers are [Misty De Meo](https://github.com/mistydemeo), [Andrew Janke](https://github.com/apjanke), [Xu Cheng](https://github.com/xu-cheng), [Mike McQuaid](https://github.com/mikemcquaid), [Baptiste Fontaine](https://github.com/bfontaine), [Brett Koonce](https://github.com/asparagui), [Martin Afanasjew](https://github.com/UniqMartin), [Dominyk Tiller](https://github.com/DomT4), [Tim Smith](https://github.com/tdsmith) and [Alex Dunn](https://github.com/dunn).

Former maintainers with significant contributions include [Jack Nagel](https://github.com/jacknagel), [Adam Vandenberg](https://github.com/adamv) and Homebrew's creator: [Max Howell](https://github.com/mxcl).

## License
Code is under the [BSD 2 Clause (NetBSD) license](https://github.com/Homebrew/homebrew/tree/master/LICENSE.txt).
Documentation is under the [Creative Commons Attribution license](https://creativecommons.org/licenses/by/4.0/).

## Sponsors
Our CI infrastructure was paid for by [our Kickstarter supporters](https://github.com/Homebrew/homebrew/blob/master/SUPPORTERS.md).

Our CI infrastructure is hosted by [The Positive Internet Company](http://www.positive-internet.com).

Our bottles (binary packages) are hosted by Bintray.

[![Downloads by Bintray](https://bintray.com/docs/images/downloads_by_bintray_96.png)](https://bintray.com/homebrew)
