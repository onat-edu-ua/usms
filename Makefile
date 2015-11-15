
pkg_name = usms
user = usms
app_dir = /home/$(user)

version = $(shell dpkg-parsechangelog --help | grep -q '\--show-field' \
	&& dpkg-parsechangelog --show-field version \
	|| dpkg-parsechangelog | grep Version | awk '{ print $$2; }')
commit = $(shell git rev-parse HEAD)
version_file = version.yml

bundle_bin=.gem/bin/bundle

bundle_cfg_dir = bundle_build_cfg

app_files = bin app .gem .gemrc .bundle config config.ru db Gemfile Gemfile.lock lib public Rakefile README.rdoc vendor $(version_file)

exclude_files = config/database.yml

env_mode = production

define info
	echo -e '\n\e[33m> msg \e[39m\n'
endef

define err
	echo -e '\n\e[31m> msg \e[39m\n'
endef

all: version.yml
	@$(info:msg=init environment)
	RAILS_ENV=$(env_mode) RACK_ENV=$(env_mode) RAKE_ENV=$(env_mode) GEM_HOME=.gem GEM_PATH=.gem make all_env

all_env:
	@$(info:msg=apply build .gemrc)
	@cp -v .gemrc_build .gemrc

	@$(info:msg=install bundler)
	@gem install bundler

	@$(info:msg=install/update gems)
	@$(bundle_bin) install

	@$(info:msg=precompile assets)
	@$(bundle_bin) exec rake assets:precompile


version.yml:
	@$(info:msg=create version file (version: $(version), commit: $(commit)))
	@echo "version:" $(version) "\ncommit:" $(commit) > $(version_file)

install: $(app_files)

	@$(info:msg=install app files)
	@mkdir -p $(DESTDIR)$(app_dir)
	tar -c --no-auto-compress $(addprefix --exclude , $(exclude_files)) $^ | tar -x -C $(DESTDIR)$(app_dir)
	@mkdir -v -p $(addprefix $(DESTDIR)$(app_dir)/, log tmp )


	@$(info:msg=install rsyslogd cfg file)
	@install -v -m0644 -D debian/$(pkg_name).rsyslog $(DESTDIR)/etc/rsyslog.d/$(pkg_name).conf

	@$(info:msg=install logrotate cfg file)
	@install -v -m0644 -D debian/$(pkg_name).logrotate $(DESTDIR)/etc/logrotate.d/$(pkg_name)

	@$(info:msg=install nginx example cfg file)
	@install -v -m0644 -D config/usms.dist.nginx $(DESTDIR)/etc/nginx/sites-available/usms
	@mkdir -p $(DESTDIR)/etc/nginx/sites-enabled
	@ln -s "../sites-available/usms" $(DESTDIR)/etc/nginx/sites-enabled/usms


clean:
	make -C debian clean
	rm -rf public/assets $(version_file)
	rm -rf .bundle_gem .gem
	cp -v .gemrc_build .gemrc

package:
	 dpkg-buildpackage -us -uc -b

chlog:
	dch -r --nomultimaint -M

.PHONY: all clean install package chlog version.yml
