From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] fibmap.f2fs: change fibmap to fibmap.f2fs
Date: Fri, 09 Aug 2013 06:42:55 +0900
Message-ID: <1375998175-26454-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1V7XzZ-00069a-Ro
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Aug 2013 21:43:33 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V7XzX-0006oO-Vp for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Aug 2013 21:43:33 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MR8005LLF0D2O20@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 09 Aug 2013 06:43:25 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: Jan Engelhardt <jengelh@inai.de>, linux-f2fs-devel@lists.sourceforge.net

The fibmap tool is for debugging f2fs especially.

CC: Changman Lee <cm224.lee@samsung.com>
CC: Jan Engelhardt <jengelh@inai.de>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fsck/Makefile.am | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index c7be063..fc54e91 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -2,11 +2,11 @@
 
 AM_CPPFLAGS = ${libuuid_CFLAGS} -I$(top_srcdir)/include
 AM_CFLAGS = -Wall
-sbin_PROGRAMS = fsck.f2fs fibmap
+sbin_PROGRAMS = fsck.f2fs fibmap.f2fs
 fsck_f2fs_SOURCES = main.c fsck.c dump.c mount.c
 fsck_f2fs_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/libf2fs.la
 
-fibmap_SOURCES = fibmap.c
+fibmap_f2fs_SOURCES = fibmap.c
 
 install-data-hook:
 	ln -sf fsck.f2fs $(DESTDIR)/$(sbindir)/dump.f2fs
-- 
1.8.3.1.437.g0dbd812


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
