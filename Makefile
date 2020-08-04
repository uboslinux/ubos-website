# Makefile for all of ubos.net, except ubos.net/docs*

UBOS_AWS_IMAGE_URL = https://console.aws.amazon.com/ec2/v2/home?region=us-east-1\#LaunchInstanceWizard:ami=ami-0038d85456ba0955a

# ubos.net variables
STAGEDIR = public

.PHONY: all clean hugo static message open

all: hugo static message

clean:
	rm -rf $(STAGEDIR)/* $(STAGEDIR)/.htacc*

hugo:
	hugo -d $(STAGEDIR)

static:
	install -m644 images/logo2/ubos-16x16.ico $(STAGEDIR)/favicon.ico
	echo 'RedirectMatch /survey https://apps.indiecomputing.com/nextcloud/index.php/apps/forms/WBC8zjEb3omz3mRN' > $(STAGEDIR)/.htaccess
	echo 'RedirectMatch /staff(.*)$$ https://ubos.net/docs/users/shepherd-staff.html' >> $(STAGEDIR)/.htaccess
	echo 'RedirectMatch /feed.xml https://ubos.net/index.xml' >> $(STAGEDIR)/.htaccess
	mkdir -p $(STAGEDIR)/include
	sed -e "s!UBOS_AWS_IMAGE_URL!$(UBOS_AWS_IMAGE_URL)!g" templates/amazon-ec2-image-latest.js.tmpl > $(STAGEDIR)/include/amazon-ec2-image-latest.js

message:
	@echo ==============================================================
	@echo "DON'T FORGET: ubos-docs neeeds to generated separately, twice!"
	@echo ==============================================================

open:
	open -a Firefox http://ubos/
