From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/6] f2fs: give scheduling point in shrinking path
Date: Mon, 25 Jan 2016 14:05:27 -0800
Message-ID: <1453759531-16076-2-git-send-email-jaegeuk@kernel.org>
References: <1453759531-16076-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aNpGb-0006Qb-2S
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 25 Jan 2016 22:05:45 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aNpGa-0003Rr-6Y for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 25 Jan 2016 22:05:45 +0000
In-Reply-To: <1453759531-16076-1-git-send-email-jaegeuk@kernel.org>
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

It needs to give a chance to be rescheduled while shrinking slab entries.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/extent_cache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 18311ff..af53503 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -593,6 +593,8 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 
 		if (node_cnt + tree_cnt >= nr_shrink)
 			goto unlock_out;
+
+		cond_resched();
 	}
 	up_write(&sbi->extent_tree_lock);
 
@@ -622,6 +624,7 @@ free_node:
 		__detach_extent_node(sbi, en->et, en);
 		write_unlock(&en->et->lock);
 		kmem_cache_free(extent_node_slab, en);
+		cond_resched();
 	}
 
 unlock_out:
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
