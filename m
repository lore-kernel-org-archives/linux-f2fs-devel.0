From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 4/6] f2fs: refactor f2fs_convert_inline_data
Date: Fri, 27 Dec 2013 13:00:18 +0900
Message-ID: <1388116820-15038-4-git-send-email-jaegeuk.kim@samsung.com>
References: <1388116820-15038-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VwOcV-0007ki-G3
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Dec 2013 04:01:55 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VwOcU-0004oc-Bp
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Dec 2013 04:01:55 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MYG00ED25UMV4A0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Dec 2013 13:01:34 +0900 (KST)
In-reply-to: <1388116820-15038-1-git-send-email-jaegeuk.kim@samsung.com>
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

This patch refactors f2fs_convert_inline_data to check a couple of conditions
internally for deciding whether it needs to convert inline_data or not.

So, the new f2fs_convert_inline_data initially checks:
1) f2fs_has_inline_data(), and
2) the data size to be changed.

If the inode has inline_data but the size to fill is less than MAX_INLINE_DATA,
then we don't need to convert the inline_data with data allocation.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/data.c   | 16 ++++++----------
 fs/f2fs/f2fs.h   |  2 +-
 fs/f2fs/file.c   | 25 +++++++++----------------
 fs/f2fs/inline.c | 26 ++++++++++++--------------
 4 files changed, 28 insertions(+), 41 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 253e663..fc7a28c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -906,21 +906,17 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 
 	f2fs_balance_fs(sbi);
 repeat:
+	err = f2fs_convert_inline_data(inode, pos + len);
+	if (err)
+		return err;
+
 	page = grab_cache_page_write_begin(mapping, index, flags);
 	if (!page)
 		return -ENOMEM;
 	*pagep = page;
 
-	if ((pos + len) < MAX_INLINE_DATA) {
-		if (f2fs_has_inline_data(inode))
-			goto inline_data;
-	} else if (f2fs_has_inline_data(inode)) {
-		err = f2fs_convert_inline_data(inode, page, flags);
-		if (err) {
-			f2fs_put_page(page, 1);
-			return err;
-		}
-	}
+	if (f2fs_has_inline_data(inode) && (pos + len) <= MAX_INLINE_DATA)
+		goto inline_data;
 
 	f2fs_lock_op(sbi);
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b01ccaa..af35039 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1302,6 +1302,6 @@ extern const struct inode_operations f2fs_special_inode_operations;
 inline int f2fs_has_inline_data(struct inode *);
 bool f2fs_may_inline(struct inode *);
 int f2fs_read_inline_data(struct inode *, struct page *);
-int f2fs_convert_inline_data(struct inode *, struct page *, unsigned);
+int f2fs_convert_inline_data(struct inode *, pgoff_t);
 int f2fs_write_inline_data(struct inode *, struct page *, unsigned int);
 #endif
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f64a1c8..68dd7bf 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -370,17 +370,12 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 
 	if ((attr->ia_valid & ATTR_SIZE) &&
 			attr->ia_size != i_size_read(inode)) {
-		if (f2fs_has_inline_data(inode) &&
-				(attr->ia_size > MAX_INLINE_DATA)) {
-			unsigned flags = AOP_FLAG_NOFS;
-			err = f2fs_convert_inline_data(inode, NULL, flags);
-			if (err)
-				return err;
-		}
+		err = f2fs_convert_inline_data(inode, attr->ia_size);
+		if (err)
+			return err;
 
 		truncate_setsize(inode, attr->ia_size);
-		if (!f2fs_has_inline_data(inode))
-			f2fs_truncate(inode);
+		f2fs_truncate(inode);
 		f2fs_balance_fs(F2FS_SB(inode->i_sb));
 	}
 
@@ -462,7 +457,7 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	loff_t off_start, off_end;
 	int ret = 0;
 
-	ret = f2fs_convert_inline_data(inode, NULL, AOP_FLAG_NOFS);
+	ret = f2fs_convert_inline_data(inode, MAX_INLINE_DATA + 1);
 	if (ret)
 		return ret;
 
@@ -512,16 +507,14 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 	loff_t off_start, off_end;
 	int ret = 0;
 
-	if (f2fs_has_inline_data(inode) && (offset + len > MAX_INLINE_DATA)) {
-		ret = f2fs_convert_inline_data(inode, NULL, AOP_FLAG_NOFS);
-		if (ret)
-			return ret;
-	}
-
 	ret = inode_newsize_ok(inode, (len + offset));
 	if (ret)
 		return ret;
 
+	ret = f2fs_convert_inline_data(inode, offset + len);
+	if (ret)
+		return ret;
+
 	pg_start = ((unsigned long long) offset) >> PAGE_CACHE_SHIFT;
 	pg_end = ((unsigned long long) offset + len) >> PAGE_CACHE_SHIFT;
 
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 62c72aa..1843bc7 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -101,6 +101,7 @@ static int __f2fs_convert_inline_data(struct inode *inode, struct page *page)
 	dst_addr = kmap(page);
 	memcpy(dst_addr, src_addr, MAX_INLINE_DATA);
 	kunmap(page);
+	SetPageUptodate(page);
 
 	/* write data page to try to make data consistent */
 	set_page_writeback(page);
@@ -120,25 +121,22 @@ static int __f2fs_convert_inline_data(struct inode *inode, struct page *page)
 	return err;
 }
 
-int f2fs_convert_inline_data(struct inode *inode,
-			     struct page *p, unsigned flags)
+int f2fs_convert_inline_data(struct inode *inode, pgoff_t to_size)
 {
-	int err;
 	struct page *page;
+	int err;
 
-	if (!p || p->index) {
-		page = grab_cache_page_write_begin(inode->i_mapping, 0, flags);
-		if (IS_ERR(page))
-			return PTR_ERR(page);
-	} else {
-		page = p;
-	}
-
-	err = __f2fs_convert_inline_data(inode, page);
+	if (!f2fs_has_inline_data(inode))
+		return 0;
+	else if (to_size <= MAX_INLINE_DATA)
+		return 0;
 
-	if (!p || p->index)
-		f2fs_put_page(page, 1);
+	page = grab_cache_page_write_begin(inode->i_mapping, 0, AOP_FLAG_NOFS);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
 
+	err = __f2fs_convert_inline_data(inode, page);
+	f2fs_put_page(page, 1);
 	return err;
 }
 
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
