From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH] f2fs: add the missing delection of orphan inode entry in
 write_orphan_inodes()
Date: Fri, 19 Jul 2013 16:18:39 +0800
Message-ID: <51E8F65F.9040007@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim <jaegeuk.kim@samsung.com>
Cc: f2fs <linux-f2fs-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

After writing orphan inode entry in jornal block, we need to delete each
entry from the orphan entry list, and release them.


Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/checkpoint.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 66a6b85..290db04 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -337,6 +337,10 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 		memset(orphan_blk, 0, sizeof(*orphan_blk));
 page_exist:
 		orphan_blk->ino[nentries++] = cpu_to_le32(orphan->ino);
+
+		list_del(&orphan->list);
+		kmem_cache_free(orphan_entry_slab, orphan);
+		sbi->n_orphans--;
 	}
 	if (!page)
 		goto end;
-- 
1.7.7
