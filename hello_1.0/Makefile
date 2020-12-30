install:
	install -d $(DESTDIR)/usr
	for fn in `find usr -type d  `; do install -m 755 -d $(DESTDIR)/$$fn; done
	for fn in `find usr -type f `; do install -m 644 $$fn $(DESTDIR)/$$fn; done

