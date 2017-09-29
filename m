From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/5] f2fs: fix to show ino management cache size correctly
Date: Fri, 29 Sep 2017 13:59:37 +0800
Message-ID: <20170929055939.39937-3-yuchao0@huawei.com>
References: <20170929055939.39937-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170929055939.39937-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

It needs to stat size of ino management cache with all type instead of
orphan ino type.

Fixes: 652be55162dc ("f2fs: show # of orphan inodes")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 14095fbb4039..d441660c3ba6 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -240,7 +240,7 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 	si->cache_mem += NM_I(sbi)->dirty_nat_cnt *
 					sizeof(struct nat_entry_set);
 	si->cache_mem += si->inmem_pages * sizeof(struct inmem_pages);
-	for (i = 0; i <= ORPHAN_INO; i++)
+	for (i = 0; i < MAX_INO_ENTRY; i++)
 		si->cache_mem += sbi->im[i].ino_num * sizeof(struct ino_entry);
 	si->cache_mem += atomic_read(&sbi->total_ext_tree) *
 						sizeof(struct extent_tree);
-- 
2.13.1.388.g69e6b9b4f4a9
