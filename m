From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: f2fs: introduce f2fs_issue_discard() to clean up
Date: Wed, 27 Nov 2013 11:46:21 +0900
Message-ID: <1385520381.2417.17.camel@kjgkr>
References: <20131126145315.GA27436@elgon.mountain>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VlVA2-0002a1-1F
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Nov 2013 02:47:30 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VlVA0-0000wl-22
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Nov 2013 02:47:29 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MWW00LTCIESJY20@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Nov 2013 11:47:16 +0900 (KST)
In-reply-to: <20131126145315.GA27436@elgon.mountain>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Dan,

Thank you for the report.

How about this?
Thanks,

>From e053b711dcf9424974d232829b9c589269c98b4d Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Date: Tue, 12 Nov 2013 16:55:17 +0900
Subject: [PATCH] f2fs: introduce f2fs_issue_discard() to clean up
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
linux-f2fs-devel@lists.sourceforge.net

Change log from v1:
 o fix 32bit drops reported by Dan Carpenter

This patch adds f2fs_issue_discard() to clean up blkdev_issue_discard()
flows.

Dan carpenter reported:
"block_t is a 32 bit type and sector_t is a 64 bit type.  The upper 32
bits of the sector_t are not used because the shift will wrap."

Bug-Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/segment.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 505a889..f95397b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -266,6 +266,14 @@ static void locate_dirty_segment(struct
f2fs_sb_info *sbi, unsigned int segno)
 	mutex_unlock(&dirty_i->seglist_lock);
 }
 
+static void f2fs_issue_discard(struct f2fs_sb_info *sbi,
+				block_t blkstart, block_t blklen)
+{
+	blkdev_issue_discard(sbi->sb->s_bdev,
+			blkstart << sbi->log_sectors_per_block,
+			blklen << sbi->log_sectors_per_block, GFP_NOFS, 0);
+}
+
 static void add_discard_addrs(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct seg_entry *se)
 {
@@ -354,22 +362,15 @@ void clear_prefree_segments(struct f2fs_sb_info
*sbi)
 		if (!test_opt(sbi, DISCARD))
 			continue;
 
-		blkdev_issue_discard(sbi->sb->s_bdev,
-				START_BLOCK(sbi, start) <<
-				sbi->log_sectors_per_block,
-				(1 << (sbi->log_sectors_per_block +
-				sbi->log_blocks_per_seg)) * (end - start),
-				GFP_NOFS, 0);
+		f2fs_issue_discard(sbi, START_BLOCK(sbi, start),
+				(end - start) << sbi->log_blocks_per_seg);
 	}
 	mutex_unlock(&dirty_i->seglist_lock);
 
 	/* send small discards */
 	list_for_each_safe(this, next, head) {
 		entry = list_entry(this, struct discard_entry, list);
-		blkdev_issue_discard(sbi->sb->s_bdev,
-				entry->blkaddr << sbi->log_sectors_per_block,
-				(1 << sbi->log_sectors_per_block) * entry->len,
-				GFP_NOFS, 0);
+		f2fs_issue_discard(sbi, entry->blkaddr, entry->len);
 		list_del(&entry->list);
 		SM_I(sbi)->nr_discards -= entry->len;
 		kmem_cache_free(discard_entry_slab, entry);
-- 
1.8.4.474.g128a96c



-- 
Jaegeuk Kim
Samsung


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
