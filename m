From: Huajun Li <huajun.li@intel.com>
Subject: [f2fs-dev] [RFC 3/5] f2fs: Key functions to handle inline data
Date: Mon,  3 Jun 2013 18:04:12 +0800
Message-ID: <1370253854-15084-4-git-send-email-huajun.li@intel.com>
References: <1370253854-15084-1-git-send-email-huajun.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <huajun.li@intel.com>) id 1UjRdY-0007lr-1Y
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 03 Jun 2013 10:05:12 +0000
Received: from mga03.intel.com ([143.182.124.21])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UjRdX-0006rF-6Q for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 03 Jun 2013 10:05:12 +0000
In-Reply-To: <1370253854-15084-1-git-send-email-huajun.li@intel.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com, linux-fsdevel@vger.kernel.org, huajun.li.lee@gmail.com
Cc: namjae.jeon@samsung.com, Huajun Li <huajun.li@intel.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Functions to implement inline data read/write, and move inline data to
normal data block when file size exceeds inline data limitation.

Signed-off-by: Huajun Li <huajun.li@intel.com>
Signed-off-by: Haicheng Li <haicheng.li@linux.intel.com>
---
 fs/f2fs/inline.c |  152 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)
 create mode 100644 fs/f2fs/inline.c

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
new file mode 100644
index 0000000..a2aa056
--- /dev/null
+++ b/fs/f2fs/inline.c
@@ -0,0 +1,152 @@
+/*
+ * fs/f2fs/inline.c
+ *
+ * Copyright (c) 2013, Intel Corporation.
+ * Authors:
+ *      Huajun Li <huajun.li@intel.com>
+ *      Haicheng Li <haicheng.li@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/fs.h>
+#include <linux/f2fs_fs.h>
+
+#include "f2fs.h"
+
+void f2fs_clear_inode_inline_flag(struct f2fs_inode *raw_inode)
+{
+	raw_inode->i_reserved &= ~F2FS_INODE_INLINE_DATA;
+}
+
+void f2fs_set_inode_inline_flag(struct f2fs_inode *raw_inode)
+{
+	raw_inode->i_reserved |= F2FS_INODE_INLINE_DATA;
+}
+
+int f2fs_inline_data_attempt(struct inode *inode)
+{
+	return is_inode_dyn_flag_set(F2FS_I(inode), F2FS_INLINE_DATA_ATTEMPT);
+}
+
+int f2fs_has_inline_data(struct inode *inode)
+{
+	return is_inode_dyn_flag_set(F2FS_I(inode), F2FS_INLINE_DATA_FL);
+}
+
+static int f2fs_read_inline_data(struct inode *inode, struct page *page)
+{
+	void *src_addr, *dst_addr;
+	loff_t size = i_size_read(inode);
+	struct page *ipage = get_node_page(F2FS_SB(inode->i_sb), inode->i_ino);
+
+	if (IS_ERR(ipage))
+		return PTR_ERR(ipage);
+
+	src_addr = page_address(ipage);
+	dst_addr = page_address(page);
+
+	memcpy(dst_addr, src_addr + INLINE_DATA_OFFSET, size);
+	zero_user_segment(page, INLINE_DATA_OFFSET + size, PAGE_CACHE_SIZE);
+	SetPageUptodate(page);
+
+	f2fs_put_page(ipage, 1);
+
+	return 0;
+}
+
+int f2fs_read_inline_data_page(struct inode *inode, struct page *page)
+{
+	int ret = 0;
+
+	if (!page->index) {
+		ret = f2fs_read_inline_data(inode, page);
+	} else if (!PageUptodate(page)) {
+		zero_user_segment(page, 0, PAGE_CACHE_SIZE);
+		SetPageUptodate(page);
+	}
+
+	unlock_page(page);
+
+	return ret;
+}
+
+int f2fs_convert_inline_data(struct page *p,
+			     struct inode *inode, unsigned flags)
+{
+	int err;
+	int ilock;
+	loff_t size;
+	struct page *page, *ipage;
+	void *src_addr, *dst_addr;
+	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
+
+	if (!p->index)
+		page = p;
+	else
+		page = grab_cache_page_write_begin(inode->i_mapping, 0, flags);
+
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
+	ipage = get_node_page(sbi, inode->i_ino);
+	if (IS_ERR(ipage)) {
+		f2fs_put_page(page, 1);
+		return PTR_ERR(ipage);
+	}
+
+	src_addr = page_address(ipage);
+	dst_addr = page_address(page);
+
+	size = i_size_read(inode);
+	memcpy(dst_addr, src_addr + INLINE_DATA_OFFSET, size);
+	zero_user_segment(ipage, INLINE_DATA_OFFSET,
+			  INLINE_DATA_OFFSET + MAX_INLINE_DATA);
+	clear_inode_dyn_flag(F2FS_I(inode), F2FS_INLINE_DATA_FL);
+	set_page_dirty(ipage);
+	f2fs_put_page(ipage, 1);
+
+	if (!p->index) {
+		SetPageUptodate(page);
+	} else {
+		ilock = mutex_lock_op(sbi);
+		err = f2fs_reserve_block(inode, 0);
+		if (err)
+			goto err;
+		mutex_unlock_op(sbi, ilock);
+
+		set_page_dirty(page);
+		f2fs_put_page(page, 1);
+	}
+
+	return 0;
+
+err:
+	mutex_unlock_op(sbi, ilock);
+	f2fs_put_page(page, 1);
+	return err;
+}
+
+int f2fs_write_inline_data(struct inode *inode,
+			   struct page *page, unsigned size)
+{
+	void *src_addr, *dst_addr;
+	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
+	struct page *ipage = get_node_page(sbi, inode->i_ino);
+
+	if (IS_ERR(ipage))
+		return PTR_ERR(ipage);
+
+	src_addr = page_address(page);
+	dst_addr = page_address(ipage);
+
+	memcpy(dst_addr + INLINE_DATA_OFFSET, src_addr, size);
+	clear_inode_dyn_flag(F2FS_I(inode), F2FS_INLINE_DATA_ATTEMPT);
+	if (!f2fs_has_inline_data(inode))
+		set_inode_dyn_flag(F2FS_I(inode), F2FS_INLINE_DATA_FL);
+	set_page_dirty(ipage);
+	f2fs_put_page(ipage, 1);
+
+	return 0;
+}
-- 
1.7.9.5


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
