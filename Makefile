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
	echo 'RedirectMatch /survey https://apps.indiecomputing.com/nextcloud/index.php/apps/forms/WBC8zjEb3omz3mRN' > $(STAGEDIR)/.htaccess
	echo 'RedirectMatch /staff(.*)$$ https://ubos.net/docs/administrators/shepherd-staff/' >> $(STAGEDIR)/.htaccess
	echo 'Redirect      /docs/users/ https://ubos.net/docs/administrators/' >> $(STAGEDIR)/.htaccess
	echo 'RedirectMatch /feed.xml https://ubos.net/index.xml' >> $(STAGEDIR)/.htaccess
	mkdir -p $(STAGEDIR)/include
	sed -e "s!UBOS_AWS_IMAGE_URL!$(UBOS_AWS_IMAGE_URL)!g" templates/amazon-ec2-image-latest.js.tmpl > $(STAGEDIR)/include/amazon-ec2-image-latest.js

upload: hugo static
	rsync -rtlvH --delete-after --delay-updates --safe-links -e ssh public/* public/.htaccess docroot@ubos.net:a9b927684f1584bd3edf8e655d0c3fa55142250ca/

