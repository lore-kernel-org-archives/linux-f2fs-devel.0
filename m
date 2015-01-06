From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: get rid of kzalloc in
 __recover_inline_status
Date: Tue, 06 Jan 2015 14:28:43 +0800
Message-ID: <009301d0297a$1fc55780$5f500680$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1Y8Ne7-0008Tz-Ts
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 06 Jan 2015 06:29:39 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Y8Ne4-0005Ss-Hb
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 06 Jan 2015 06:29:39 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NHQ00E0ZSP48580@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 06 Jan 2015 15:29:28 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We use kzalloc to allocate memory in __recover_inline_status, and use this
all-zero memory to check the inline date content of inode page by comparing
them. This is low effective and not needed, let's check inline date content
directly.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/inode.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 3a8958d..8be0fd5 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -67,29 +67,25 @@ static void __set_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
 	}
 }
 
-static int __recover_inline_status(struct inode *inode, struct page *ipage)
+static void __recover_inline_status(struct inode *inode, struct page *ipage)
 {
 	void *inline_data = inline_data_addr(ipage);
+	__le32 *start = inline_data;
+	__le32 *end = start + MAX_INLINE_DATA / sizeof(__le32);
 	struct f2fs_inode *ri;
-	void *zbuf;
-
-	zbuf = kzalloc(MAX_INLINE_DATA, GFP_NOFS);
-	if (!zbuf)
-		return -ENOMEM;
-
-	if (!memcmp(zbuf, inline_data, MAX_INLINE_DATA)) {
-		kfree(zbuf);
-		return 0;
-	}
-	kfree(zbuf);
 
+	while (start < end)
+		if (*start++)
+			goto recover;
+	return;
+recover:
 	f2fs_wait_on_page_writeback(ipage, NODE);
 	set_inode_flag(F2FS_I(inode), FI_DATA_EXIST);
 
 	ri = F2FS_INODE(ipage);
 	set_raw_inline(F2FS_I(inode), ri);
 	set_page_dirty(ipage);
-	return 0;
+	return;
 }
 
 static int do_read_inode(struct inode *inode)
@@ -98,7 +94,6 @@ static int do_read_inode(struct inode *inode)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct page *node_page;
 	struct f2fs_inode *ri;
-	int err = 0;
 
 	/* Check if ino is within scope */
 	if (check_nid_range(sbi, inode->i_ino)) {
@@ -142,7 +137,7 @@ static int do_read_inode(struct inode *inode)
 
 	/* check data exist */
 	if (f2fs_has_inline_data(inode) && !f2fs_exist_data(inode))
-		err = __recover_inline_status(inode, node_page);
+		__recover_inline_status(inode, node_page);
 
 	/* get rdev by using inline_info */
 	__get_inode_rdev(inode, ri);
@@ -152,7 +147,7 @@ static int do_read_inode(struct inode *inode)
 	stat_inc_inline_inode(inode);
 	stat_inc_inline_dir(inode);
 
-	return err;
+	return 0;
 }
 
 struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
-- 
2.2.1



------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
