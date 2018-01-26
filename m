From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] fsck: fix missing endian conversion
Date: Fri, 26 Jan 2018 17:31:15 +0800
Message-ID: <1516959075-9717-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1ef0a7-0003wA-JG
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 26 Jan 2018 09:45:59 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ef0a5-0000Zu-Gp
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 26 Jan 2018 09:45:59 +0000
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

This patch fix missing endian conversion in function
build_nat_area_bitmap

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fsck/mount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index fe0d510..5289a1b 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -2225,7 +2225,7 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 		if (fsck->entries[nid].block_addr != 0x0) {
 			fsck->chk.valid_nat_entry_cnt--;
 			f2fs_clear_bit(nid, fsck->nat_area_bitmap);
-			if (fsck->entries[nid].ino == nid)
+			if (le32_to_cpu(fsck->entries[nid].ino) == nid)
 				fsck->nat_valid_inode_cnt--;
 		}
 
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
