From: "Russ W. Knize" <russ@knizefamily.net>
Subject: [PATCH 1/2] f2fs: don't let the orphan inode counter underflow
Date: Tue, 24 Sep 2013 09:35:40 -0500
Message-ID: <781db395defea58bdfae75c378eca2be@www.metagalaxy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Accounting errors from buggy code calling the acquire/release/remove
orphan inode interfaces can cause n_orphans to underflow, which will
then cause acquire_orphan_inode() to return -ENOSPC on the next
operation.  This commit guards against that condition.

Signed-off-by: Russ Knize <rknize@motorola.com>
---
  fs/f2fs/checkpoint.c |    2 ++
  1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f2a7c98..2afa32b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -206,6 +206,7 @@ int acquire_orphan_inode(struct f2fs_sb_info *sbi)
  void release_orphan_inode(struct f2fs_sb_info *sbi)
  {
  	mutex_lock(&sbi->orphan_inode_mutex);
+	BUG_ON(sbi->n_orphans == 0);
  	sbi->n_orphans--;
  	mutex_unlock(&sbi->orphan_inode_mutex);
  }
@@ -253,6 +254,7 @@ void remove_orphan_inode(struct f2fs_sb_info *sbi, 
nid_t ino)
  		if (orphan->ino == ino) {
  			list_del(&orphan->list);
  			kmem_cache_free(orphan_entry_slab, orphan);
+			BUG_ON(sbi->n_orphans == 0);
  			sbi->n_orphans--;
  			break;
  		}
-- 
1.7.9.5

