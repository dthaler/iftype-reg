draft-thaler-iftype-reg.txt: draft-thaler-iftype-reg.xml
	xml2rfc draft-thaler-iftype-reg.xml

draft-thaler-iftype-reg.xml: draft-thaler-iftype-reg.md
	kramdown-rfc2629 draft-thaler-iftype-reg.md > draft-thaler-iftype-reg.xml
