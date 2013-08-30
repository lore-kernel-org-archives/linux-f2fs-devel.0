From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs-tools: discard is default but not set in
	config
Date: Sat, 31 Aug 2013 08:41:31 +0900
Message-ID: <1377906091-3971-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1VFYLY-00080H-CI
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Aug 2013 23:43:20 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VFYLW-0005Lx-Bn for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Aug 2013 23:43:20 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MSD00EVJB7U12B0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 31 Aug 2013 08:43:11 +0900 (KST)
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

flash devices support discard therefore discard is default but not set
in config

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 lib/libf2fs.c      |    1 +
 mkfs/f2fs_format.c |    1 +
 2 files changed, 2 insertions(+)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 6947425..9046986 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -364,6 +364,7 @@ void f2fs_init_configuration(struct f2fs_configuration *c)
 	c->heap = 1;
 	c->vol_label = "";
 	c->device_name = NULL;
+	c->trim = 1;
 }
 
 static int is_mounted(const char *mpt, const char *device)
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 5b017c7..364bb46 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -917,6 +917,7 @@ int f2fs_trim_device()
 		return -1;
 	}
 
+	MSG(0, "Info: Discarding device\n");
 	if (S_ISREG(stat_buf.st_mode))
 		return 0;
 	else if (S_ISBLK(stat_buf.st_mode)) {
-- 
1.7.9.5


------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
