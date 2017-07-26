From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: don't give partially written atomic
 data from process crash
Date: Tue, 25 Jul 2017 18:29:21 -0700
Message-ID: <20170726012921.53002-2-jaegeuk@kernel.org>
References: <20170726012921.53002-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1daB8k-0001Kc-UC
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 Jul 2017 01:29:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1daB8j-00031q-Vl
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 Jul 2017 01:29:30 +0000
In-Reply-To: <20170726012921.53002-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch resolves the below scenario.

== Process 1 ==     == Process 2 ==
open(w)             open(rw)
begin
write(new_#1)
process_crash
  f_op->flush
  locks_remove_posix
  f_op>release
                    read (new_#1)

In order to avoid corrupted database caused by new_#1, we must do roll-back
at process_crash time. In order to check that, this patch keeps task which
triggers transaction begin, and does roll-back in f_op->flush before removing
file locks.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/file.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a336021b777f..3e48c2ac2f21 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -565,6 +565,7 @@ struct f2fs_inode_info {
 	struct list_head dirty_list;	/* dirty list for dirs and files */
 	struct list_head gdirty_list;	/* linked in global dirty list */
 	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
+	struct task_struct *inmem_task;	/* store inmemory task */
 	struct mutex inmem_lock;	/* lock for inmemory pages */
 	struct extent_tree *extent_tree;	/* cached extent_tree entry */
 	struct rw_semaphore dio_rwsem[2];/* avoid racing between dio and gc */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0f4dbeb61845..cb0a013859e6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1502,6 +1502,22 @@ static int f2fs_release_file(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static int f2fs_file_flush(struct file *file, fl_owner_t id)
+{
+	struct inode *inode = file_inode(file);
+
+	/*
+	 * If the process doing a transaction is crashed, we should do
+	 * roll-back. Otherwise, other reader/write can see corrupted database
+	 * until all the writers close its file. Since this should be done
+	 * before dropping file lock, it needs to do in ->flush.
+	 */
+	if (f2fs_is_atomic_file(inode) &&
+			F2FS_I(inode)->inmem_task == current)
+		drop_inmem_pages(inode);
+	return 0;
+}
+
 static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -1608,6 +1624,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	}
 
 inc_stat:
+	F2FS_I(inode)->inmem_task = current;
 	stat_inc_atomic_write(inode);
 	stat_update_max_atomic_write(inode);
 out:
@@ -2514,6 +2531,7 @@ const struct file_operations f2fs_file_operations = {
 	.open		= f2fs_file_open,
 	.release	= f2fs_release_file,
 	.mmap		= f2fs_file_mmap,
+	.flush		= f2fs_file_flush,
 	.fsync		= f2fs_sync_file,
 	.fallocate	= f2fs_fallocate,
 	.unlocked_ioctl	= f2fs_ioctl,
-- 
2.13.0.rc1.294.g07d810a77f-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
