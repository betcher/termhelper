PREFIX ?= /usr
BINDIR ?= $(PREFIX)/bin
DATADIR ?= $(PREFIX)/share
LOCALEDIR ?= $(DATADIR)/locale
MANDIR ?= $(DATADIR)/man
SYSCONFDIR ?= /etc
UNITDIR ?= /usr/lib/systemd/system

install:
	mkdir -p $(DESTDIR)$(BINDIR)
	install -m 755 termhelper $(DESTDIR)$(BINDIR)
	install -m 755 termhelper-functions $(DESTDIR)$(BINDIR)
	install -m 755 wiki2helper $(DESTDIR)$(BINDIR)
	mkdir -p $(DESTDIR)$(DATADIR)/termhelper/ru
	mkdir -p $(DESTDIR)$(DATADIR)/termhelper/en
	install -m 644 ./helps/ru/* $(DESTDIR)$(DATADIR)/termhelper/ru
	install -m 644 ./helps/en/* $(DESTDIR)$(DATADIR)/termhelper/en
	ln -s ./en $(DESTDIR)$(DATADIR)/termhelper/C
	ln -s ./en $(DESTDIR)$(DATADIR)/termhelper/POSIX
	mkdir -p $(DESTDIR)$(LOCALEDIR)/ru/LC_MESSAGES
	msgfmt -o $(DESTDIR)$(LOCALEDIR)/ru/LC_MESSAGES/termhelper.mo ./gettext/termhelper.po
	mkdir -p $(DESTDIR)$(MANDIR)
	cp -fr  ./man/* $(DESTDIR)$(MANDIR)
	#mkdir -p $(DESTDIR)$(DATADIR)/bash-completion/completions
	#install -m 644 ./bash-completion/termhelper $(DESTDIR)$(DATADIR)/bash-completion/completions
	# XXX Something breaks completions for "справка" when in /usr/share,
	# probably "alias справка=termhelper" in /etc/profile.d/*
	mkdir -p $(DESTDIR)$(SYSCONFDIR)/bash_completion.d
	install -m 644 ./bash-completion/termhelper $(DESTDIR)$(SYSCONFDIR)/bash_completion.d
	mkdir -p $(DESTDIR)$(SYSCONFDIR)/profile.d
	install -m 644 ./profile.d/*.sh $(DESTDIR)$(SYSCONFDIR)/profile.d
	mkdir -p $(DESTDIR)$(SYSCONFDIR)/anaconda-scripts.d/post-install
	install -m 755 setup-helpers/anaconda-termhelper.sh $(DESTDIR)$(SYSCONFDIR)/anaconda-scripts.d/post-install
	mkdir -p $(DESTDIR)$(SYSCONFDIR)/anaconda-scripts.d/livecd-init
	install -m 755 setup-helpers/termhelper-estimate-speed.sh $(DESTDIR)$(SYSCONFDIR)/anaconda-scripts.d/livecd-init
	install -m 755 setup-helpers/termhelper-estimate-speed.sh $(DESTDIR)$(BINDIR)/termhelper-estimate-speed
	mkdir -p $(DESTDIR)$(UNITDIR)
	install -m 644 setup-helpers/termhelper-estimate-speed.service $(DESTDIR)$(UNITDIR)
	
	
