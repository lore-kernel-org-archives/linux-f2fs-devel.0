From: Chao Yu <chao@kernel.org>
Subject: [PATCH 6/6] f2fs: show dirty inode number
Date: Sun, 18 Sep 2016 23:30:08 +0800
Message-ID: <1474212608-6930-6-git-send-email-chao@kernel.org>
References: <1474212608-6930-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1ble5O-0003fj-UJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 18 Sep 2016 15:32:54 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ble5O-0007B0-8C
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 18 Sep 2016 15:32:54 +0000
In-Reply-To: <1474212608-6930-1-git-send-email-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch enables showing dirty inode number in procfs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/debug.c | 3 +++
 fs/f2fs/f2fs.h  | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index ae13521..fb245bd 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -45,6 +45,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->ndirty_dent = get_pages(sbi, F2FS_DIRTY_DENTS);
 	si->ndirty_meta = get_pages(sbi, F2FS_DIRTY_META);
 	si->ndirty_data = get_pages(sbi, F2FS_DIRTY_DATA);
+	si->ndirty_imeta = get_pages(sbi, F2FS_DIRTY_IMETA);
 	si->ndirty_dirs = sbi->ndirty_inode[DIR_INODE];
 	si->ndirty_files = sbi->ndirty_inode[FILE_INODE];
 	si->ndirty_all = sbi->ndirty_inode[DIRTY_META];
@@ -319,6 +320,8 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->ndirty_data, si->ndirty_files);
 		seq_printf(s, "  - meta: %4lld in %4d\n",
 			   si->ndirty_meta, si->meta_pages);
+		seq_printf(s, "  - imeta: %4lld\n",
+			   si->ndirty_imeta);
 		seq_printf(s, "  - NATs: %9d/%9d\n  - SITs: %9d/%9d\n",
 			   si->dirty_nats, si->nats, si->dirty_sits, si->sits);
 		seq_printf(s, "  - free_nids: %9d\n",
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a1a68bf..be23825 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2191,7 +2191,8 @@ struct f2fs_stat_info {
 	unsigned long long hit_largest, hit_cached, hit_rbtree;
 	unsigned long long hit_total, total_ext;
 	int ext_tree, zombie_tree, ext_node;
-	s64 ndirty_node, ndirty_dent, ndirty_meta, ndirty_data, inmem_pages;
+	s64 ndirty_node, ndirty_dent, ndirty_meta, ndirty_data, ndirty_imeta;
+	s64 inmem_pages;
 	unsigned int ndirty_dirs, ndirty_files, ndirty_all;
 	int nats, dirty_nats, sits, dirty_sits, fnids;
 	int total_count, utilization;
-- 
2.7.2


------------------------------------------------------------------------------
