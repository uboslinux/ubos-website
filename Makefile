# Makefile for all of ubos.net, except ubos.net/docs*

UBOS_AWS_IMAGE_URL = https://console.aws.amazon.com/ec2/v2/home?region=us-east-1\#LaunchInstanceWizard:ami=ami-0363a4bb10fa9a766

# ubos.net variables
STAGEDIR = public
STATICDIR = static

.PHONY: all clean hugo static open

all: hugo static

clean:
	rm -rf $(STAGEDIR)/* $(STAGEDIR)/.htacc*

hugo:
	hugo -d $(STAGEDIR)

static:
	install -m644 images/logo2/ubos-16x16.ico $(STATICDIR)/favicon.ico
	echo 'RedirectMatch /survey https://apps.indiecomputing.com/nextcloud/index.php/apps/forms/WBC8zjEb3omz3mRN' > $(STATICDIR)/.htaccess
	echo 'RedirectMatch /staff(.*)$$ https://ubos.net/docs/users/shepherd-staff/' >> $(STATICDIR)/.htaccess
	echo 'RedirectMatch /feed.xml https://ubos.net/index.xml' >> $(STATICDIR)/.htaccess
	mkdir -p $(STATICDIR)/include
	sed -e "s!UBOS_AWS_IMAGE_URL!$(UBOS_AWS_IMAGE_URL)!g" templates/amazon-ec2-image-latest.js.tmpl > $(STATICDIR)/include/amazon-ec2-image-latest.js

open:
	open -a Firefox http://ubos/
