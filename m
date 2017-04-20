From: William Brana <wbrana@gmail.com>
Subject: 4.9.23: hang on sync
Date: Thu, 20 Apr 2017 13:54:23 +0200
Message-ID: <CAJ7jCmkr3eD3V+GHMQXV2Erd3tq6ByXb=j5a2hQF9sy6+7RT8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wbrana@gmail.com>) id 1d1AfO-0002Us-Nv
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 20 Apr 2017 11:54:30 +0000
Received: from mail-ua0-f171.google.com ([209.85.217.171])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1d1AfN-0004Yn-KC
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 20 Apr 2017 11:54:30 +0000
Received: by mail-ua0-f171.google.com with SMTP id j59so3635540uad.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 20 Apr 2017 04:54:29 -0700 (PDT)
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

command sync was hung with
partition size: 2 GB
mkfs.f2fs -s 12
400 MB of small files https://gentoo.osuosl.org/snapshots/portage-latest.tar.xz

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
