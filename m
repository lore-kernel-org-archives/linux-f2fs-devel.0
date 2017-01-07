From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/5] f2fs: clean up with list_{first, last}_entry
Date: Sat, 7 Jan 2017 18:49:42 +0800
Message-ID: <4e37899b-d508-9949-2caa-51850046e29d@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cPodm-0005Bu-ER
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 Jan 2017 10:54:26 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1cPodk-0004Ad-VG for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 Jan 2017 10:54:26 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 4 ++--
 fs/f2fs/data.c       | 4 ++--
 fs/f2fs/node.h       | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f1e5970d7918..d0bc62700470 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -892,7 +892,7 @@ int sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
 				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA));
 		return 0;
 	}
-	fi = list_entry(head->next, struct f2fs_inode_info, dirty_list);
+	fi = list_first_entry(head, struct f2fs_inode_info, dirty_list);
 	inode = igrab(&fi->vfs_inode);
 	spin_unlock(&sbi->inode_lock[type]);
 	if (inode) {
@@ -925,7 +925,7 @@ int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi)
 			spin_unlock(&sbi->inode_lock[DIRTY_META]);
 			return 0;
 		}
-		fi = list_entry(head->next, struct f2fs_inode_info,
+		fi = list_first_entry(head, struct f2fs_inode_info,
 							gdirty_list);
 		inode = igrab(&fi->vfs_inode);
 		spin_unlock(&sbi->inode_lock[DIRTY_META]);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1e4049529a06..3732a1aae6f7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1145,7 +1145,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,

 		prefetchw(&page->flags);
 		if (pages) {
-			page = list_entry(pages->prev, struct page, lru);
+			page = list_last_entry(pages, struct page, lru);
 			list_del(&page->lru);
 			if (add_to_page_cache_lru(page, mapping,
 						  page->index,
@@ -1264,7 +1264,7 @@ static int f2fs_read_data_pages(struct file *file,
 			struct list_head *pages, unsigned nr_pages)
 {
 	struct inode *inode = file->f_mapping->host;
-	struct page *page = list_entry(pages->prev, struct page, lru);
+	struct page *page = list_last_entry(pages, struct page, lru);

 	trace_f2fs_readpages(inode, page, nr_pages);

diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index e7997e240366..9278b21ee073 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -174,7 +174,7 @@ static inline void next_free_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 		spin_unlock(&nm_i->nid_list_lock);
 		return;
 	}
-	fnid = list_entry(nm_i->nid_list[FREE_NID_LIST].next,
+	fnid = list_first_entry(&nm_i->nid_list[FREE_NID_LIST],
 						struct free_nid, list);
 	*nid = fnid->nid;
 	spin_unlock(&nm_i->nid_list_lock);
-- 
2.8.2.295.g3f1c1d0



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
