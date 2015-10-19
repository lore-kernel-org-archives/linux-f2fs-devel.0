From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: support fiemap for inline_data
Date: Mon, 19 Oct 2015 11:48:41 -0700
Message-ID: <1445280521-25973-2-git-send-email-jaegeuk@kernel.org>
References: <1445280521-25973-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZoFUR-0005Lt-Cx
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Oct 2015 18:48:59 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZoFUQ-0001MH-1Y for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Oct 2015 18:48:59 +0000
In-Reply-To: <1445280521-25973-1-git-send-email-jaegeuk@kernel.org>
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

There is a FIEMAP_EXTENT_INLINE_DATA, pointed out by Marc.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c   |  6 ++++++
 fs/f2fs/f2fs.h   |  2 ++
 fs/f2fs/inline.c | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b052e7c..972eab7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -771,6 +771,12 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (ret)
 		return ret;
 
+	if (f2fs_has_inline_data(inode)) {
+		ret = f2fs_inline_data_fiemap(inode, fieinfo, start, len);
+		if (ret != -EAGAIN)
+			return ret;
+	}
+
 	mutex_lock(&inode->i_mutex);
 
 	if (len >= isize) {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c3443da..9db5500 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2054,6 +2054,8 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *, struct page *,
 bool f2fs_empty_inline_dir(struct inode *);
 int f2fs_read_inline_dir(struct file *, struct dir_context *,
 						struct f2fs_str *);
+int f2fs_inline_data_fiemap(struct inode *,
+		struct fiemap_extent_info *, __u64, __u64);
 
 /*
  * shrinker.c
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 3b18e23..bda7126 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -12,6 +12,7 @@
 #include <linux/f2fs_fs.h>
 
 #include "f2fs.h"
+#include "node.h"
 
 bool f2fs_may_inline_data(struct inode *inode)
 {
@@ -570,3 +571,38 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 	f2fs_put_page(ipage, 1);
 	return 0;
 }
+
+int f2fs_inline_data_fiemap(struct inode *inode,
+		struct fiemap_extent_info *fieinfo, __u64 start, __u64 len)
+{
+	__u64 byteaddr, ilen;
+	__u32 flags = FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_NOT_ALIGNED |
+		FIEMAP_EXTENT_LAST;
+	struct node_info ni;
+	struct page *ipage;
+	int err = 0;
+
+	ipage = get_node_page(F2FS_I_SB(inode), inode->i_ino);
+	if (IS_ERR(ipage))
+		return PTR_ERR(ipage);
+
+	if (!f2fs_has_inline_data(inode)) {
+		err = -EAGAIN;
+		goto out;
+	}
+
+	ilen = min_t(size_t, MAX_INLINE_DATA, i_size_read(inode));
+	if (start >= ilen)
+		goto out;
+	if (start + len < ilen)
+		ilen = start + len;
+	ilen -= start;
+
+	get_node_info(F2FS_I_SB(inode), inode->i_ino, &ni);
+	byteaddr = (__u64)ni.blk_addr << inode->i_sb->s_blocksize_bits;
+	byteaddr += (char *)inline_data_addr(ipage) - (char *)F2FS_INODE(ipage);
+	err = fiemap_fill_next_extent(fieinfo, start, byteaddr, ilen, flags);
+out:
+	f2fs_put_page(ipage, 1);
+	return err;
+}
-- 
2.1.1


------------------------------------------------------------------------------
