From: folkert <folkert@vanheusden.com>
Subject: [f2fs-dev] fails to build
Date: Sat, 6 Jul 2013 16:50:15 +0200
Message-ID: <20130706145001.GB19245@belle.intranet.vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <folkert@vanheusden.com>) id 1UvUCq-0005Oc-G9
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 06 Jul 2013 15:15:24 +0000
Received: from keetweej.vanheusden.com ([80.101.105.103])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UvUCo-0005p7-C7
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 06 Jul 2013 15:15:24 +0000
Received: from belle.intranet.vanheusden.com (unknown [192.168.64.100])
	by keetweej.vanheusden.com (Postfix) with ESMTP id 729A016247E
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat,  6 Jul 2013 16:50:16 +0200 (CEST)
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Hi,

f2fs-tools fails to build:

root@vnvnation:/usr/src/f2fs-tools# autoreconf --install
configure.ac:36: installing `build-aux/install-sh'
configure.ac:36: installing `build-aux/missing'
fsck/Makefile.am: installing `build-aux/depcomp'
lib/Makefile.am:3: Libtool library used but `LIBTOOL' is undefined
lib/Makefile.am:3:   The usual way to define `LIBTOOL' is to add `LT_INIT'
lib/Makefile.am:3:   to `configure.ac' and run `aclocal' and `autoconf' aga=
in.
lib/Makefile.am:3:   If `LT_INIT' is in `configure.ac', make sure
lib/Makefile.am:3:   its definition is in aclocal's search path.
autoreconf: automake failed with exit status: 1

I tried adding LT_INIT to configure.ac but that did not help.

Any ideas?

Also: please consider publishing debian packages.


Folkert van Heusden

-- =

Multitail es una herramienta flexible que permite visualizar los "log
file" y seguir la ejecuci=F3n de comandos. Permite filtrar, a=F1adir
colores, combinar archivos, la visualizaci=F3n de diferencias (diff-
view), etc.  http://www.vanheusden.com/multitail/
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
