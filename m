From: Jin Qian <jinqian@google.com>
Subject: [PATCH 1/1] f2fs-tools: sanity check blk_off for summary
	block entries
Date: Thu, 27 Apr 2017 11:29:22 -0700
Message-ID: <20170427182922.28266-1-jinqian@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jinqian@google.com>) id 1d3oBB-0006Wv-JQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Apr 2017 18:30:13 +0000
Received: from mail-pf0-f181.google.com ([209.85.192.181])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1d3oB9-0000dH-Lf
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Apr 2017 18:30:13 +0000
Received: by mail-pf0-f181.google.com with SMTP id a188so34575523pfa.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 27 Apr 2017 11:30:11 -0700 (PDT)
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
Cc: jaegeuk@kernel.org

crafted malicious f2fs partition can fill an out of bound blk_off,
which cause overflow when accessing summary block entries.

Signed-off-by: Jin Qian <jinqian@google.com>
---
 fsck/mount.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index 761baa0..0a63b71 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -889,6 +889,8 @@ static void read_compacted_summaries(struct f2fs_sb_info *sbi)
 		else
 			blk_off = curseg->next_blkoff;
 
+		ASSERT(blk_off <= ENTRIES_IN_SUM);
+
 		for (j = 0; j < blk_off; j++) {
 			struct f2fs_summary *s;
 			s = (struct f2fs_summary *)(kaddr + offset);
-- 
2.13.0.rc0.306.g87b477812d-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
