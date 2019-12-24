# Makefile for all of ubos.net, except ubos.net/docs*

UBOS_AWS_IMAGE_URL = https://console.aws.amazon.com/ec2/v2/home?region=us-east-1\#LaunchInstanceWizard:ami=ami-0d8ef2daa4f058346

# ubos.net variables
STAGEDIR = stage
CACHEDIR = cache

.PHONY: all clean hugo static message open

all: hugo static message

clean:
	rm -rf $(STAGEDIR)/* $(CACHEDIR)/*

hugo:
	( cd hugo; hugo -d ../$(STAGEDIR))

static:
	[ -d "reveal/git" ] || echo "WARNING: revealjs github repo not present at ./reveal"
	install -m644 images/logo2/ubos-16x16.ico $(STAGEDIR)/favicon.ico
	[ -d "$(STAGEDIR)/files" ]  || mkdir "$(STAGEDIR)/files"
	[ -d "$(STAGEDIR)/slides" ] || mkdir "$(STAGEDIR)/slides"
	install -m644 files/* $(STAGEDIR)/files/
	echo 'RedirectMatch /survey https://www.surveymonkey.com/s/FVNSNYN' > $(STAGEDIR)/.htaccess
	echo 'RedirectMatch /staff(.*)$$ https://ubos.net/docs/users/shepherd-staff.html' >> $(STAGEDIR)/.htaccess
	mkdir -p $(STAGEDIR)/include
	sed -e "s!UBOS_AWS_IMAGE_URL!$(UBOS_AWS_IMAGE_URL)!g" hugo/static/include/amazon-ec2-image-latest.js > $(STAGEDIR)/include/amazon-ec2-image-latest.js

message:
	@echo ==============================================================
	@echo "DON'T FORGET: ubos-docs neeeds to generated separately, twice!"
	@echo ==============================================================

open:
	open -a Firefox http://ubos/
