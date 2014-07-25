From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 02/11] f2fs: punch the core function for inode
	management
Date: Fri, 25 Jul 2014 15:47:16 -0700
Message-ID: <1406328445-63707-2-git-send-email-jaegeuk@kernel.org>
References: <1406328445-63707-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XAoGy-0001FV-D8
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Jul 2014 22:47:32 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XAoGw-00024m-HL for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Jul 2014 22:47:31 +0000
In-Reply-To: <1406328445-63707-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch punches out the core functions to manage the inode numbers.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 81 ++++++++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 37 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 0b4710c..3e3c2c3 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -282,6 +282,47 @@ const struct address_space_operations f2fs_meta_aops = {
 	.set_page_dirty	= f2fs_set_meta_page_dirty,
 };
 
+static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino)
+{
+	struct list_head *head;
+	struct ino_entry *new, *e;
+
+	new = f2fs_kmem_cache_alloc(orphan_entry_slab, GFP_ATOMIC);
+	new->ino = ino;
+
+	spin_lock(&sbi->orphan_inode_lock);
+	list_for_each_entry(e, &sbi->orphan_inode_list, list) {
+		if (e->ino == ino) {
+			spin_unlock(&sbi->orphan_inode_lock);
+			kmem_cache_free(orphan_entry_slab, new);
+			return;
+		}
+		if (e->ino > ino)
+			break;
+	}
+
+	/* add new entry into list which is sorted by inode number */
+	list_add_tail(&new->list, &e->list);
+	spin_unlock(&sbi->orphan_inode_lock);
+}
+
+static void __remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino)
+{
+	struct ino_entry *e;
+
+	spin_lock(&sbi->orphan_inode_lock);
+	list_for_each_entry(e, &sbi->orphan_inode_list, list) {
+		if (e->ino == ino) {
+			list_del(&e->list);
+			sbi->n_orphans--;
+			spin_unlock(&sbi->orphan_inode_lock);
+			kmem_cache_free(orphan_entry_slab, e);
+			return;
+		}
+	}
+	spin_unlock(&sbi->orphan_inode_lock);
+}
+
 int acquire_orphan_inode(struct f2fs_sb_info *sbi)
 {
 	int err = 0;
@@ -306,48 +347,14 @@ void release_orphan_inode(struct f2fs_sb_info *sbi)
 
 void add_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 {
-	struct list_head *head;
-	struct orphan_inode_entry *new, *orphan;
-
-	new = f2fs_kmem_cache_alloc(orphan_entry_slab, GFP_ATOMIC);
-	new->ino = ino;
-
-	spin_lock(&sbi->orphan_inode_lock);
-	head = &sbi->orphan_inode_list;
-	list_for_each_entry(orphan, head, list) {
-		if (orphan->ino == ino) {
-			spin_unlock(&sbi->orphan_inode_lock);
-			kmem_cache_free(orphan_entry_slab, new);
-			return;
-		}
-
-		if (orphan->ino > ino)
-			break;
-	}
-
 	/* add new orphan entry into list which is sorted by inode number */
-	list_add_tail(&new->list, &orphan->list);
-	spin_unlock(&sbi->orphan_inode_lock);
+	__add_ino_entry(sbi, ino);
 }
 
 void remove_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 {
-	struct list_head *head;
-	struct orphan_inode_entry *orphan;
-
-	spin_lock(&sbi->orphan_inode_lock);
-	head = &sbi->orphan_inode_list;
-	list_for_each_entry(orphan, head, list) {
-		if (orphan->ino == ino) {
-			list_del(&orphan->list);
-			f2fs_bug_on(sbi->n_orphans == 0);
-			sbi->n_orphans--;
-			spin_unlock(&sbi->orphan_inode_lock);
-			kmem_cache_free(orphan_entry_slab, orphan);
-			return;
-		}
-	}
-	spin_unlock(&sbi->orphan_inode_lock);
+	/* remove orphan entry from orphan list */
+	__remove_ino_entry(sbi, ino);
 }
 
 static void recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
