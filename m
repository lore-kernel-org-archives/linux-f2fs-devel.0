From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] fsck.f2fs: use mem nat info directly
Date: Mon, 22 Jan 2018 20:03:46 +0800
Message-ID: <1516622626-1486-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1edb3N-0005e6-4V
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 22 Jan 2018 12:18:21 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1edb3L-0008Iw-Ik
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 22 Jan 2018 12:18:21 +0000
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

Use mem nat info directly for we built in fsck init.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fsck/mount.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 0a5b986..fe0d510 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1591,8 +1591,14 @@ void update_nat_blkaddr(struct f2fs_sb_info *sbi, nid_t ino,
 void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
 {
 	struct f2fs_nat_entry raw_nat;
-	get_nat_entry(sbi, nid, &raw_nat);
+
 	ni->nid = nid;
+	if (c.func == FSCK) {
+		node_info_from_raw_nat(ni, &(F2FS_FSCK(sbi)->entries[nid]));
+		return;
+	}
+
+	get_nat_entry(sbi, nid, &raw_nat);
 	node_info_from_raw_nat(ni, &raw_nat);
 }
 
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
