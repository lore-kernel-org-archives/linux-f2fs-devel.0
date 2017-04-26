From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] mkfs.f2fs: fix wrong segment assignment
Date: Tue, 25 Apr 2017 17:53:41 -0700
Message-ID: <20170426005341.12232-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1d3BDL-0004oA-0N
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 26 Apr 2017 00:53:51 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d3BDK-000449-4T
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 26 Apr 2017 00:53:50 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

We must guarantee that current segments should be different between different
logs.
This should resolve xfstests/generic/015 panic.

Fixes: 8f9327c0c02ee1 ("mkfs.f2fs: use noheap by default")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 mkfs/f2fs_format.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index ca47385..d354c88 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -117,6 +117,24 @@ next:
 	free(c.extension_list);
 }
 
+static void verify_cur_segs(void)
+{
+	int i, j;
+
+	for (i = 0; i < NR_CURSEG_TYPE; i++) {
+		for (j = 0; j < NR_CURSEG_TYPE; j++)
+			if (c.cur_seg[i] == c.cur_seg[j])
+				break;
+	}
+
+	if (i == NR_CURSEG_TYPE && j == NR_CURSEG_TYPE)
+		return;
+
+	c.cur_seg[0] = 0;
+	for (i = 1; i < NR_CURSEG_TYPE; i++)
+		c.cur_seg[i] = next_zone(i - 1);
+}
+
 static int f2fs_prepare_super_block(void)
 {
 	u_int32_t blk_size_bytes;
@@ -384,6 +402,9 @@ static int f2fs_prepare_super_block(void)
 					next_zone(CURSEG_COLD_DATA));
 	}
 
+	/* if there is redundancy, reassign it */
+	verify_cur_segs();
+
 	cure_extension_list();
 
 	/* get kernel version */
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
