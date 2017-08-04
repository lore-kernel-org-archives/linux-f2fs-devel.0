From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs-tools: support inode checksum
Date: Thu, 3 Aug 2017 18:38:58 -0700
Message-ID: <20170804013858.GA81291@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170726150135.9641-1-chao@kernel.org>
 <20170726214059.GB66153@jaegeuk-macbookpro.roam.corp.google.com>
 <6422dc23-bad7-435c-30ac-005e813b2db6@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6422dc23-bad7-435c-30ac-005e813b2db6@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

It seems three is missing case when verifying the checksum, if the page is
got from cache with some updates. We need to verify it when actually reading
the node block.

Let me modify your patch like this. Is that okay for you?

Thanks,

---
 fs/f2fs/f2fs.h    |  3 ++-
 fs/f2fs/inode.c   | 62 +++++++++++++++++++++++++++++--------------------------
 fs/f2fs/node.c    |  7 ++++++-
 fs/f2fs/segment.c |  2 +-
 4 files changed, 42 insertions(+), 32 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5a078cd6f68d..44e46a31509b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2362,7 +2362,8 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
  * inode.c
  */
 void f2fs_set_inode_flags(struct inode *inode);
-void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct f2fs_node *node);
+bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page);
+void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct page *page);
 struct inode *f2fs_iget(struct super_block *sb, unsigned long ino);
 struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino);
 int try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 05c8aeb0101e..b4c401d456e7 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -108,9 +108,26 @@ static void __recover_inline_status(struct inode *inode, struct page *ipage)
 	return;
 }
 
-static __u32 f2fs_inode_chksum(struct f2fs_sb_info *sbi,
-					struct f2fs_node *node)
+static bool f2fs_enable_inode_chksum(struct f2fs_sb_info *sbi, struct page *page)
 {
+	struct f2fs_inode *ri = &F2FS_NODE(page)->i;
+	int extra_isize = le32_to_cpu(ri->i_extra_isize);
+
+	if (!f2fs_sb_has_inode_chksum(sbi->sb))
+		return false;
+
+	if (!RAW_IS_INODE(F2FS_NODE(page)) || !(ri->i_inline & F2FS_EXTRA_ATTR))
+		return false;
+
+	if (!F2FS_FITS_IN_INODE(ri, extra_isize, i_inode_checksum))
+		return false;
+
+	return true;
+}
+
+static __u32 f2fs_inode_chksum(struct f2fs_sb_info *sbi, struct page *page)
+{
+	struct f2fs_node *node = F2FS_NODE(page);
 	struct f2fs_inode *ri = &node->i;
 	__le32 ino = node->footer.ino;
 	__le32 gen = ri->i_generation;
@@ -131,39 +148,34 @@ static __u32 f2fs_inode_chksum(struct f2fs_sb_info *sbi,
 	return chksum;
 }
 
-static bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi,
-			struct f2fs_node *node, struct f2fs_inode_info *fi)
+bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page)
 {
-	struct f2fs_inode *ri = &node->i;
+	struct f2fs_inode *ri;
 	__u32 provided, calculated;
 
-	if (!f2fs_sb_has_inode_chksum(sbi->sb))
-		return true;
-
-	if (!F2FS_FITS_IN_INODE(ri, fi->i_extra_isize, i_inode_checksum))
+	if (!f2fs_enable_inode_chksum(sbi, page))
 		return true;
 
+	ri = &F2FS_NODE(page)->i;
 	provided = le32_to_cpu(ri->i_inode_checksum);
-	calculated = f2fs_inode_chksum(sbi, node);
+	calculated = f2fs_inode_chksum(sbi, page);
+
+	if (provided != calculated)
+		f2fs_msg(sbi->sb, KERN_WARNING,
+			"checksum invalid, ino = %x, %x vs. %x",
+			ino_of_node(page), provided, calculated);
 
 	return provided == calculated;
 }
 
-void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct f2fs_node *node)
+void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct page *page)
 {
-	struct f2fs_inode *ri = &node->i;
-	int extra_isize = le32_to_cpu(ri->i_extra_isize);
-
-	if (!f2fs_sb_has_inode_chksum(sbi->sb))
-		return;
-
-	if (!RAW_IS_INODE(node) || !(ri->i_inline & F2FS_EXTRA_ATTR))
-		return;
+	struct f2fs_inode *ri = &F2FS_NODE(page)->i;
 
-	if (!F2FS_FITS_IN_INODE(ri, extra_isize, i_inode_checksum))
+	if (!f2fs_enable_inode_chksum(sbi, page))
 		return;
 
-	ri->i_inode_checksum = cpu_to_le32(f2fs_inode_chksum(sbi, node));
+	ri->i_inode_checksum = cpu_to_le32(f2fs_inode_chksum(sbi, page));
 }
 
 static int do_read_inode(struct inode *inode)
@@ -219,14 +231,6 @@ static int do_read_inode(struct inode *inode)
 	fi->i_extra_isize = f2fs_has_extra_attr(inode) ?
 					le16_to_cpu(ri->i_extra_isize) : 0;
 
-	if (!f2fs_inode_chksum_verify(sbi, F2FS_NODE(node_page), fi)) {
-		f2fs_msg(sbi->sb, KERN_WARNING,
-			"checksum invalid, ino:%lu, on-disk:%u",
-			inode->i_ino, le32_to_cpu(ri->i_inode_checksum));
-		f2fs_put_page(node_page, 1);
-		return -EBADMSG;
-	}
-
 	/* check data exist */
 	if (f2fs_has_inline_data(inode) && !f2fs_exist_data(inode))
 		__recover_inline_status(inode, node_page);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b08f0d9bd86f..9168c304fd58 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1171,6 +1171,11 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 		err = -EIO;
 		goto out_err;
 	}
+
+	if (!f2fs_inode_chksum_verify(sbi, page)) {
+		err = -EBADMSG;
+		goto out_err;
+	}
 page_hit:
 	if(unlikely(nid != nid_of_node(page))) {
 		f2fs_msg(sbi->sb, KERN_WARNING, "inconsistent node block, "
@@ -2279,7 +2284,7 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 								i_projid))
 			dst->i_projid = src->i_projid;
 
-		f2fs_inode_chksum_set(sbi, F2FS_NODE(ipage));
+		f2fs_inode_chksum_set(sbi, ipage);
 	}
 
 	new_ni = old_ni;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 151968ecc694..d9f4497890d7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2222,7 +2222,7 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	if (page && IS_NODESEG(type)) {
 		fill_node_footer_blkaddr(page, NEXT_FREE_BLKADDR(sbi, curseg));
 
-		f2fs_inode_chksum_set(sbi, F2FS_NODE(page));
+		f2fs_inode_chksum_set(sbi, page);
 	}
 
 	if (add_list) {
-- 
2.13.0.rc1.294.g07d810a77f-goog
