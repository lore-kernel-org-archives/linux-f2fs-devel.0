From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH v5] f2fs: avoid dead loop in function
 find_fsync_dnodes
Date: Wed, 20 Dec 2017 13:03:32 +0800
Message-ID: <1513746212-19454-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1eRWkm-0005yw-Tv
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Dec 2017 05:17:16 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eRWkl-0000yF-2v
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Dec 2017 05:17:16 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: ning.jia@huawei.com, heyunlei@huawei.com

v4 -> v5 return err instead destory inode list for two reasons:
i.  avoid duplicated destroy inode list in function recover_fsync_data.
ii. report an error for recovery, and set need_fsck flag
        
Came across a dead loop in recovery like this:

......
[   24.680480s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597696
[   24.698394s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597697
[   24.724334s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
[   24.724334s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
[   24.724365s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
[   24.724365s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
[   24.724365s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
[   24.724395s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
[   24.724395s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
[   24.724395s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
[   24.724395s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
[   24.724426s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
......

Mount process will block in dead loop and fsck can do nothing with this
error, This patch abandon recovery if node chain is cyclical.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/recovery.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index d025aa8..a535ec2 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -216,6 +216,17 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 			return 0;
 
 		page = get_tmp_page(sbi, blkaddr);
+		if (PageChecked(page)) {
+			f2fs_msg(sbi->sb, KERN_ERR, "Abandon looped node block list");
+			err = -EINVAL;
+			break;
+		}
+
+		/*
+		 * it's not needed to clear PG_checked flag in temp page since we
+		 * will truncate all those pages in the end of recovery.
+		 */
+		SetPageChecked(page);
 
 		if (!is_recoverable_dnode(page))
 			break;
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
