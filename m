From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to handle looped node chain during
 recovery
Date: Sat, 3 Feb 2018 17:44:39 +0800
Message-ID: <20180203094439.3913-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1ehuNi-0006aM-7A
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 03 Feb 2018 09:45:10 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ehuNg-0002Ud-1G
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 03 Feb 2018 09:45:10 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: Yunlei He <heyunlei@huawei.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

There is no checksum in node block now, so bit-transition from hardware
can make node_footer.next_blkaddr being corrupted w/o any detection,
result in node chain becoming looped one.

For this condition, during recovery, in order to avoid running into dead
loop, let's detect it and just skip out.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/recovery.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index b6d1ec620a8c..60dd0cee4820 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -243,6 +243,9 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 	struct curseg_info *curseg;
 	struct page *page = NULL;
 	block_t blkaddr;
+	unsigned int loop_cnt = 0;
+	unsigned int free_blocks = sbi->user_block_count -
+					valid_user_blocks(sbi);
 	int err = 0;
 
 	/* get node pages in the current segment */
@@ -295,6 +298,17 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 		if (IS_INODE(page) && is_dent_dnode(page))
 			entry->last_dentry = blkaddr;
 next:
+		/* sanity check in order to detect looped node chain */
+		if (++loop_cnt >= free_blocks ||
+			blkaddr == next_blkaddr_of_node(page)) {
+			f2fs_msg(sbi->sb, KERN_NOTICE,
+				"%s: detect looped node chain, "
+				"blkaddr:%u, next:%u",
+				__func__, blkaddr, next_blkaddr_of_node(page));
+			err = -EINVAL;
+			break;
+		}
+
 		/* check next segment */
 		blkaddr = next_blkaddr_of_node(page);
 		f2fs_put_page(page, 1);
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
