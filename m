From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH 1/2] f2fs: fix iget/iput of dir during recovery
Date: Fri, 07 Jun 2013 14:55:56 +0900
Message-ID: <1370584557-20592-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Ukpg0-0004Rp-S2
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Jun 2013 05:57:28 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ukpfy-0004aK-L3 for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Jun 2013 05:57:28 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MO000AGLDV8EWJ0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Jun 2013 14:57:19 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

It is possible that iput is skipped after iget during the recovery.

In recover_dentry(),
 dir = f2fs_iget();
 ...
 if (de && inode->i_ino == le32_to_cpu(de->ino))
	goto out;

In this case, this dir is not able to be added in dirty_dir_inode_list.
The actual linking is done only when set_page_dirty() is called.

So let's add this newly got inode into the list explicitly, and put it at the
end of the recovery routine.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/checkpoint.c | 55 +++++++++++++++++++++++++++++++++++++---------------
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/recovery.c   |  1 +
 3 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 6f56e57..9a77509 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -450,13 +450,30 @@ fail_no_cp:
 	return -EINVAL;
 }
 
-void set_dirty_dir_page(struct inode *inode, struct page *page)
+static int __add_dirty_inode(struct inode *inode, struct dir_inode_entry *new)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 	struct list_head *head = &sbi->dir_inode_list;
-	struct dir_inode_entry *new;
 	struct list_head *this;
 
+	list_for_each(this, head) {
+		struct dir_inode_entry *entry;
+		entry = list_entry(this, struct dir_inode_entry, list);
+		if (entry->inode == inode)
+			return -EEXIST;
+	}
+	list_add_tail(&new->list, head);
+#ifdef CONFIG_F2FS_STAT_FS
+	sbi->n_dirty_dirs++;
+#endif
+	return 0;
+}
+
+void set_dirty_dir_page(struct inode *inode, struct page *page)
+{
+	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
+	struct dir_inode_entry *new;
+
 	if (!S_ISDIR(inode->i_mode))
 		return;
 retry:
@@ -469,25 +486,31 @@ retry:
 	INIT_LIST_HEAD(&new->list);
 
 	spin_lock(&sbi->dir_inode_lock);
-	list_for_each(this, head) {
-		struct dir_inode_entry *entry;
-		entry = list_entry(this, struct dir_inode_entry, list);
-		if (entry->inode == inode) {
-			kmem_cache_free(inode_entry_slab, new);
-			goto out;
-		}
-	}
-	list_add_tail(&new->list, head);
-#ifdef CONFIG_F2FS_STAT_FS
-	sbi->n_dirty_dirs++;
-#endif
+	if (__add_dirty_inode(inode, new))
+		kmem_cache_free(inode_entry_slab, new);
 
-	BUG_ON(!S_ISDIR(inode->i_mode));
-out:
 	inc_page_count(sbi, F2FS_DIRTY_DENTS);
 	inode_inc_dirty_dents(inode);
 	SetPagePrivate(page);
+	spin_unlock(&sbi->dir_inode_lock);
+}
+
+void add_dirty_dir_inode(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
+	struct dir_inode_entry *new;
+retry:
+	new = kmem_cache_alloc(inode_entry_slab, GFP_NOFS);
+	if (!new) {
+		cond_resched();
+		goto retry;
+	}
+	new->inode = inode;
+	INIT_LIST_HEAD(&new->list);
 
+	spin_lock(&sbi->dir_inode_lock);
+	if (__add_dirty_inode(inode, new))
+		kmem_cache_free(inode_entry_slab, new);
 	spin_unlock(&sbi->dir_inode_lock);
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 40b137a..d6e63da 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1030,6 +1030,7 @@ void remove_orphan_inode(struct f2fs_sb_info *, nid_t);
 int recover_orphan_inodes(struct f2fs_sb_info *);
 int get_valid_checkpoint(struct f2fs_sb_info *);
 void set_dirty_dir_page(struct inode *, struct page *);
+void add_dirty_dir_inode(struct inode *);
 void remove_dirty_dir_inode(struct inode *);
 struct inode *check_dirty_dir_inode(struct f2fs_sb_info *, nid_t);
 void sync_dirty_dir_inodes(struct f2fs_sb_info *);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 539ca32..ddde14f 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -58,6 +58,7 @@ static int recover_dentry(struct page *ipage, struct inode *inode)
 			goto out;
 		}
 		set_inode_flag(F2FS_I(dir), FI_DELAY_IPUT);
+		add_dirty_dir_inode(dir);
 	}
 
 	name.len = le32_to_cpu(raw_inode->i_namelen);
-- 
1.8.1.3.566.gaa39828


------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
