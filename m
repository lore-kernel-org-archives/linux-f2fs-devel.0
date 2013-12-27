From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 6/6] f2fs: add inline_data recovery routine
Date: Fri, 27 Dec 2013 13:00:20 +0900
Message-ID: <1388116820-15038-6-git-send-email-jaegeuk.kim@samsung.com>
References: <1388116820-15038-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VwOcS-0008Ua-4P
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Dec 2013 04:01:52 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VwOcR-0001CU-0k
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Dec 2013 04:01:52 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MYG005ZC5UMIQB0@mailout2.samsung.com> for
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

This patch adds a inline_data recovery routine with the following policy.

[prev.] [next] of inline_data flag
   o       o  -> recover inline_data
   o       x  -> remove inline_data, and then recover data blocks
   x       o  -> remove inline_data, and then recover inline_data
   x       x  -> recover data blocks

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h          |  2 ++
 fs/f2fs/file.c          |  2 +-
 fs/f2fs/inline.c        | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/recovery.c      |  8 ++++++--
 include/linux/f2fs_fs.h |  3 +--
 5 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ef4073f..6991a28 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1010,6 +1010,7 @@ static inline int f2fs_readonly(struct super_block *sb)
  */
 int f2fs_sync_file(struct file *, loff_t, loff_t, int);
 void truncate_data_blocks(struct dnode_of_data *);
+int truncate_blocks(struct inode *, u64);
 void f2fs_truncate(struct inode *);
 int f2fs_getattr(struct vfsmount *, struct dentry *, struct kstat *);
 int f2fs_setattr(struct dentry *, struct iattr *);
@@ -1318,4 +1319,5 @@ bool f2fs_may_inline(struct inode *);
 int f2fs_read_inline_data(struct inode *, struct page *);
 int f2fs_convert_inline_data(struct inode *, pgoff_t);
 int f2fs_write_inline_data(struct inode *, struct page *, unsigned int);
+int recover_inline_data(struct inode *, struct page *);
 #endif
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 68dd7bf..c77ad4d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -251,7 +251,7 @@ static void truncate_partial_data_page(struct inode *inode, u64 from)
 	f2fs_put_page(page, 1);
 }
 
-static int truncate_blocks(struct inode *inode, u64 from)
+int truncate_blocks(struct inode *inode, u64 from)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 	unsigned int blocksize = inode->i_sb->s_blocksize;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 048f601..0e940ce 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -174,3 +174,51 @@ int f2fs_write_inline_data(struct inode *inode,
 
 	return 0;
 }
+
+int recover_inline_data(struct inode *inode, struct page *npage)
+{
+	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
+	struct f2fs_inode *ri = NULL;
+	void *src_addr, *dst_addr;
+	struct page *ipage;
+
+	/*
+	 * The inline_data recovery policy is as follows.
+	 * [prev.] [next] of inline_data flag
+	 *    o       o  -> recover inline_data
+	 *    o       x  -> remove inline_data, and then recover data blocks
+	 *    x       o  -> remove inline_data, and then recover inline_data
+	 *    x       x  -> recover data blocks
+	 */
+	if (IS_INODE(npage))
+		ri = F2FS_INODE(npage);
+
+	if (f2fs_has_inline_data(inode) &&
+			ri && ri->i_inline & F2FS_INLINE_DATA) {
+process_inline:
+		ipage = get_node_page(sbi, inode->i_ino);
+		f2fs_bug_on(IS_ERR(ipage));
+
+		src_addr = inline_data_addr(npage);
+		dst_addr = inline_data_addr(ipage);
+		memcpy(dst_addr, src_addr, MAX_INLINE_DATA);
+		update_inode(inode, ipage);
+		f2fs_put_page(ipage, 1);
+		return -1;
+	}
+
+	if (f2fs_has_inline_data(inode)) {
+		ipage = get_node_page(sbi, inode->i_ino);
+		f2fs_bug_on(IS_ERR(ipage));
+		zero_user_segment(ipage, INLINE_DATA_OFFSET,
+				 INLINE_DATA_OFFSET + MAX_INLINE_DATA);
+		clear_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
+		update_inode(inode, ipage);
+		f2fs_put_page(ipage, 1);
+	} else if (ri && ri->i_inline & F2FS_INLINE_DATA) {
+		truncate_blocks(inode, 0);
+		set_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
+		goto process_inline;
+	}
+	return 0;
+}
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 96e690b6..655791e 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -298,6 +298,9 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	struct node_info ni;
 	int err = 0, recovered = 0;
 
+	if (recover_inline_data(inode, page))
+		goto out;
+
 	start = start_bidx_of_node(ofs_of_node(page), fi);
 	if (IS_INODE(page))
 		end = start + ADDRS_PER_INODE(fi);
@@ -305,12 +308,13 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		end = start + ADDRS_PER_BLOCK;
 
 	f2fs_lock_op(sbi);
+
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 
 	err = get_dnode_of_data(&dn, start, ALLOC_NODE);
 	if (err) {
 		f2fs_unlock_op(sbi);
-		return err;
+		goto out;
 	}
 
 	wait_on_page_writeback(dn.node_page);
@@ -361,7 +365,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 err:
 	f2fs_put_dnode(&dn);
 	f2fs_unlock_op(sbi);
-
+out:
 	f2fs_msg(sbi->sb, KERN_NOTICE, "recover_data: ino = %lx, "
 			"recovered_data = %d blocks, err = %d",
 			inode->i_ino, recovered, err);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index aea5eed..da74d87 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -155,12 +155,11 @@ struct f2fs_extent {
 #define F2FS_INLINE_XATTR	0x01	/* file inline xattr flag */
 #define F2FS_INLINE_DATA	0x02	/* file inline data flag */
 
-
 #define MAX_INLINE_DATA		(sizeof(__le32) * (DEF_ADDRS_PER_INODE - \
 						F2FS_INLINE_XATTR_ADDRS - 1))
 
 #define INLINE_DATA_OFFSET	(PAGE_CACHE_SIZE - sizeof(struct node_footer) \
-				- sizeof(__le32)*(DEF_ADDRS_PER_INODE + 5 - 1))
+			- sizeof(__le32) * (DEF_ADDRS_PER_INODE + 5 - 1))
 
 struct f2fs_inode {
 	__le16 i_mode;			/* file mode */
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
