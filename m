From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: support f2fs_fiemap
Date: Tue, 10 Jun 2014 01:23:07 +0900
Message-ID: <1402330987-65438-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Wu2Lv-0002p4-TT
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 09 Jun 2014 16:23:19 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wu2Lu-00074A-Uc for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 09 Jun 2014 16:23:19 +0000
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

This patch links f2fs_fiemap with generic function with get_block.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 6 ++++++
 fs/f2fs/f2fs.h | 1 +
 fs/f2fs/file.c | 1 +
 3 files changed, 8 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 39fe7d7..c1fb6dd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -708,6 +708,12 @@ out:
 	return err;
 }
 
+int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		u64 start, u64 len)
+{
+	return generic_block_fiemap(inode, fieinfo, start, len, get_data_block);
+}
+
 static int f2fs_read_data_page(struct file *file, struct page *page)
 {
 	struct inode *inode = page->mapping->host;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f628c3c..e51c732 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1271,6 +1271,7 @@ struct page *find_data_page(struct inode *, pgoff_t, bool);
 struct page *get_lock_data_page(struct inode *, pgoff_t);
 struct page *get_new_data_page(struct inode *, struct page *, pgoff_t, bool);
 int do_write_data_page(struct page *, struct f2fs_io_info *);
+int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *, u64, u64);
 
 /*
  * gc.c
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 78110da..9c49c59 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -540,6 +540,7 @@ const struct inode_operations f2fs_file_inode_operations = {
 	.listxattr	= f2fs_listxattr,
 	.removexattr	= generic_removexattr,
 #endif
+	.fiemap		= f2fs_fiemap,
 };
 
 static void fill_zero(struct inode *inode, pgoff_t index,
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://www.hpccsystems.com
