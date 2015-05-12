From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: get rid of buggy function
Date: Mon, 11 May 2015 20:48:48 -0700
Message-ID: <1431402528-24156-3-git-send-email-jaegeuk@kernel.org>
References: <1431402528-24156-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Ys1Bn-000876-4Y
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 May 2015 03:49:03 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ys1Bm-0004QW-E3 for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 May 2015 03:49:03 +0000
In-Reply-To: <1431402528-24156-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch avoids to use a buggy function for now.
It needs to fix it later.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 342e0f7..17e89ba 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -64,6 +64,8 @@ static inline unsigned long __reverse_ffs(unsigned long word)
 	return num;
 }
 
+/* FIXME: Do not use this due to a subtle bug */
+#if 0
 /*
  * __find_rev_next(_zero)_bit is copied from lib/find_next_bit.c because
  * f2fs_set_bit makes MSB and LSB reversed in a byte.
@@ -122,6 +124,7 @@ found_first:
 found_middle:
 	return result + __reverse_ffs(tmp);
 }
+#endif
 
 static unsigned long __find_rev_next_zero_bit(const unsigned long *addr,
 			unsigned long size, unsigned long offset)
@@ -542,7 +545,7 @@ static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
 	unsigned long *discard_map = (unsigned long *)se->discard_map;
 	unsigned long *dmap = SIT_I(sbi)->tmp_map;
-	unsigned int start = 0, end = -1;
+	unsigned int start = -1, end = 0;
 	bool force = (cpc->reason == CP_DISCARD);
 	int i;
 
@@ -561,12 +564,14 @@ static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 				(cur_map[i] ^ ckpt_map[i]) & ckpt_map[i];
 
 	while (force || SM_I(sbi)->nr_discards <= SM_I(sbi)->max_discards) {
-		start = __find_rev_next_bit(dmap, max_blocks, end + 1);
-		if (start >= max_blocks)
-			break;
 
 		end = __find_rev_next_zero_bit(dmap, max_blocks, start + 1);
-		__add_discard_entry(sbi, cpc, se, start, end);
+
+		__add_discard_entry(sbi, cpc, se, start + 1, end);
+
+		if (end >= max_blocks)
+			break;
+		start = end;
 	}
 }
 
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
