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
	ln -sf ./termhelper $(DESTDIR)$(BINDIR)/th
	install -m 755 termhelper-functions $(DESTDIR)$(BINDIR)
	install -m 755 wiki2helper $(DESTDIR)$(BINDIR)
	mkdir -p $(DESTDIR)$(DATADIR)/termhelper/ru
	mkdir -p $(DESTDIR)$(DATADIR)/termhelper/en
	mkdir -p $(DESTDIR)$(DATADIR)/termhelper/it
	# install command does not preserve simlinks
	cp -P ./helps/ru/* $(DESTDIR)$(DATADIR)/termhelper/ru/
	cp -P ./helps/en/* $(DESTDIR)$(DATADIR)/termhelper/en/
	cp -P ./helps/it/* $(DESTDIR)$(DATADIR)/termhelper/it/
	find $(DESTDIR)$(DATADIR)/termhelper/ -type f -exec chmod 644 {} \;  
	ln -sf ./en $(DESTDIR)$(DATADIR)/termhelper/C
	ln -sf ./en $(DESTDIR)$(DATADIR)/termhelper/POSIX
	mkdir -p $(DESTDIR)$(LOCALEDIR)/ru/LC_MESSAGES
	msgfmt -o $(DESTDIR)$(LOCALEDIR)/ru/LC_MESSAGES/termhelper.mo ./gettext/termhelper.po.ru
	mkdir -p $(DESTDIR)$(LOCALEDIR)/it/LC_MESSAGES
	msgfmt -o $(DESTDIR)$(LOCALEDIR)/it/LC_MESSAGES/termhelper.mo ./gettext/termhelper.po.it
	mkdir -p $(DESTDIR)$(MANDIR)
	cp -fr  ./man/* $(DESTDIR)$(MANDIR)
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
	mkdir -p $(DESTDIR)$(DATADIR)/termhelper/header_logo
	cp header_logo/* $(DESTDIR)$(DATADIR)/termhelper/header_logo/

