From: JP Abgrall <jpa@google.com>
Subject: [PATCH] fsck.f2fs: add a missing 'fixed' during
	chk_dentries()
Date: Thu, 13 Nov 2014 15:20:05 -0800
Message-ID: <1415920805-28748-1-git-send-email-jpa@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jpa@google.com>) id 1Xp3gg-0005Cn-D6
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Nov 2014 23:20:26 +0000
Received: from mail-qc0-f202.google.com ([209.85.216.202])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Xp3gf-0005Wp-Ln
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Nov 2014 23:20:26 +0000
Received: by mail-qc0-f202.google.com with SMTP id x3so49814qcv.5
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 13 Nov 2014 15:20:20 -0800 (PST)
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

One of the cases would update the dentries but not set
fixed=1 causing the update to not be written out.

Change-Id: I111d599f93f7d5306dacd7d62da946fdb5c262ee
Signed-off-by: JP Abgrall <jpa@google.com>
---
:100644 100644 78737d5... fa667dc... M	fsck/fsck.c
 fsck/fsck.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 78737d5..fa667dc 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -739,6 +739,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, u32 *child_cnt,
 					dentry[i].file_type);
 			i += slots;
 			free(name);
+			fixed = 1;
 			continue;
 		}
 
-- 
2.1.0.rc2.206.gedb03e5


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
