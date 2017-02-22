From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 2/2] f2fs:use fggc_set_cold_data instead of
	set_cold_data in fggc
Date: Wed, 22 Feb 2017 10:29:00 +0000
Message-ID: <20170222102900.152902-2-houpengyang@huawei.com>
References: <20170222102900.152902-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1cgUAn-00046P-HP
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Feb 2017 10:29:25 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cgUAl-00028a-AQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Feb 2017 10:29:25 +0000
In-Reply-To: <20170222102900.152902-1-houpengyang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

When no dirty colde segment for fggc ssr, we do NOT set_cold_data.

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 fs/f2fs/gc.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 4ee749f..a0eed23 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -666,6 +666,25 @@ static void move_encrypted_block(struct inode *inode, block_t bidx,
 	f2fs_put_page(page, 1);
 }
 
+/*
+ * If NOT enough dirty cold data segments for fggc, fggc would consume
+ * a valuable free segment, which would slow down the fggc procedure,
+ * If there are NO COLD dirty segment, we do not set_cold_page.
+ */
+static void fggc_set_cold_data(struct page *page)
+{
+	struct f2fs_sb_info *sbi = F2FS_P_SB(page);
+	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
+	int nr_cold_dirties;
+
+	mutex_lock(&dirty_i->seglist_lock);
+	nr_cold_dirties = dirty_i->nr_dirty[DIRTY_COLD_DATA];
+	mutex_unlock(&dirty_i->seglist_lock);
+
+	if (nr_cold_dirties)
+		set_cold_data(page);
+
+}
 static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 							unsigned int segno, int off)
 {
@@ -706,7 +725,7 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 			remove_dirty_inode(inode);
 		}
 
-		set_cold_data(page);
+		fggc_set_cold_data(page);
 
 		err = do_write_data_page(&fio);
 		if (err == -ENOMEM && is_dirty) {
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
