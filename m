From: "Russ W. Knize" <rknize@gmail.com>
Subject: [PATCH 2/2] f2fs: account for orphan inodes during recovery
Date: Tue, 24 Sep 2013 09:40:57 -0500
Message-ID: <925870294c69c592c792dab867475df6@www.metagalaxy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

During recovery, orphan inodes are deleted via truncate_hole().
These orphans are added by recover_dentry() via f2fs_delete_entry().
However, f2fs_delete_entry() adds them via add_orphan_inode()
without calling acquire_orphan_inode() first.  This prevents the
counters from being incremented properly, which causes them to
underflow when remove_orphan_inode() is called later on.

Signed-off-by: Russ Knize <rknize@motorola.com>
---
  fs/f2fs/recovery.c |   19 +++++++++++++------
  1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index e8cf621..908066d 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -67,24 +67,31 @@ static int recover_dentry(struct page *ipage, 
struct inode *inode)
  	name.name = raw_inode->i_name;
  retry:
  	de = f2fs_find_entry(dir, &name, &page);
-	if (de && inode->i_ino == le32_to_cpu(de->ino)) {
-		kunmap(page);
-		f2fs_put_page(page, 0);
-		goto out;
-	}
+	if (de && inode->i_ino == le32_to_cpu(de->ino))
+		goto out_unmap_put;
  	if (de) {
  		einode = f2fs_iget(inode->i_sb, le32_to_cpu(de->ino));
  		if (IS_ERR(einode)) {
  			WARN_ON(1);
  			if (PTR_ERR(einode) == -ENOENT)
  				err = -EEXIST;
-			goto out;
+			goto out_unmap_put;
+		}
+		err = acquire_orphan_inode(F2FS_SB(inode->i_sb));
+		if (err) {
+			iput(einode);
+			goto out_unmap_put;
  		}
  		f2fs_delete_entry(de, page, einode);
  		iput(einode);
  		goto retry;
  	}
  	err = __f2fs_add_link(dir, &name, inode);
+	goto out;
+
+out_unmap_put:
+	kunmap(page);
+	f2fs_put_page(page, 0);
  out:
  	f2fs_msg(inode->i_sb, KERN_DEBUG, "recover_inode and its dentry: "
  			"ino = %x, name = %s, dir = %lx, err = %d",
-- 
1.7.9.5

