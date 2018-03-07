From: Weichao Guo <guoweichao@huawei.com>
Subject: [PATCH v4] f2fs: support in-memory inode checksum when
 checking consistency
Date: Thu, 8 Mar 2018 05:10:40 +0800
Message-ID: <20180307211040.219117-1-guoweichao@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <guoweichao@huawei.com>) id 1etYkX-001Qja-7h
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 07 Mar 2018 13:04:53 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1etYkR-0032iX-8Q
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 07 Mar 2018 13:04:53 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: yuchao0@huawei.com, jaegeuk@kernel.org
Cc: heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Only enable in-memory inode checksum to protect metadata blocks
from in-memory scribbles when checking consistency, which has no
performance requirements.
---
 fs/f2fs/inline.c | 18 ++++++++++++++++++
 fs/f2fs/inode.c  | 10 ++++++++++
 fs/f2fs/node.c   |  4 +++-
 fs/f2fs/node.h   | 24 ++++++++++++++++++++++++
 fs/f2fs/xattr.c  |  3 +++
 5 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 90e38d8..73330ed 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -75,6 +75,9 @@ void truncate_inline_inode(struct inode *inode, struct page *ipage, u64 from)
 
 	f2fs_wait_on_page_writeback(ipage, NODE, true);
 	memset(addr + from, 0, MAX_INLINE_DATA(inode) - from);
+#ifdef CONFIG_F2FS_CHECK_FS
+	f2fs_inode_chksum_set(F2FS_I_SB(inode), ipage);
+#endif
 	set_page_dirty(ipage);
 
 	if (from == 0)
@@ -223,6 +226,9 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
 	src_addr = kmap_atomic(page);
 	dst_addr = inline_data_addr(inode, dn.inode_page);
 	memcpy(dst_addr, src_addr, MAX_INLINE_DATA(inode));
+#ifdef CONFIG_F2FS_CHECK_FS
+	f2fs_inode_chksum_set(F2FS_I_SB(inode), dn.inode_page);
+#endif
 	kunmap_atomic(src_addr);
 	set_page_dirty(dn.inode_page);
 
@@ -268,6 +274,9 @@ bool recover_inline_data(struct inode *inode, struct page *npage)
 		src_addr = inline_data_addr(inode, npage);
 		dst_addr = inline_data_addr(inode, ipage);
 		memcpy(dst_addr, src_addr, MAX_INLINE_DATA(inode));
+#ifdef CONFIG_F2FS_CHECK_FS
+		f2fs_inode_chksum_set(sbi, ipage);
+#endif
 
 		set_inode_flag(inode, FI_INLINE_DATA);
 		set_inode_flag(inode, FI_DATA_EXIST);
@@ -334,6 +343,9 @@ int make_empty_inline_dir(struct inode *inode, struct inode *parent,
 	make_dentry_ptr_inline(inode, &d, inline_dentry);
 	do_make_empty_dir(inode, parent, &d);
 
+#ifdef CONFIG_F2FS_CHECK_FS
+	f2fs_inode_chksum_set(F2FS_I_SB(inode), ipage);
+#endif
 	set_page_dirty(ipage);
 
 	/* update i_size to MAX_INLINE_DATA */
@@ -546,6 +558,9 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
 	name_hash = f2fs_dentry_hash(new_name, NULL);
 	f2fs_update_dentry(ino, mode, &d, new_name, name_hash, bit_pos);
 
+#ifdef CONFIG_F2FS_CHECK_FS
+	f2fs_inode_chksum_set(sbi, ipage);
+#endif
 	set_page_dirty(ipage);
 
 	/* we don't need to mark_inode_dirty now */
@@ -582,6 +597,9 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	for (i = 0; i < slots; i++)
 		__clear_bit_le(bit_pos + i, d.bitmap);
 
+#ifdef CONFIG_F2FS_CHECK_FS
+	f2fs_inode_chksum_set(F2FS_I_SB(dir), page);
+#endif
 	set_page_dirty(page);
 	f2fs_put_page(page, 1);
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 205add3..300e613 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -107,6 +107,9 @@ static void __recover_inline_status(struct inode *inode, struct page *ipage)
 
 			set_inode_flag(inode, FI_DATA_EXIST);
 			set_raw_inline(inode, F2FS_INODE(ipage));
+#ifdef CONFIG_F2FS_CHECK_FS
+			f2fs_inode_chksum_set(F2FS_I_SB(inode), ipage);
+#endif
 			set_page_dirty(ipage);
 			return;
 		}
@@ -159,8 +162,12 @@ bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page)
 	struct f2fs_inode *ri;
 	__u32 provided, calculated;
 
+#ifdef CONFIG_F2FS_CHECK_FS
+	if (!f2fs_enable_inode_chksum(sbi, page))
+#else
 	if (!f2fs_enable_inode_chksum(sbi, page) ||
 			PageDirty(page) || PageWriteback(page))
+#endif
 		return true;
 
 	ri = &F2FS_NODE(page)->i;
@@ -445,6 +452,9 @@ void update_inode(struct inode *inode, struct page *node_page)
 	if (inode->i_nlink == 0)
 		clear_inline_node(node_page);
 
+#ifdef CONFIG_F2FS_CHECK_FS
+	f2fs_inode_chksum_set(F2FS_I_SB(inode), node_page);
+#endif
 }
 
 void update_inode_page(struct inode *inode)
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 177c438..2adeb74 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1113,8 +1113,10 @@ static int read_node_page(struct page *page, int op_flags)
 		.encrypted_page = NULL,
 	};
 
-	if (PageUptodate(page))
+	if (PageUptodate(page)) {
+		f2fs_bug_on(sbi, !f2fs_inode_chksum_verify(sbi, page));
 		return LOCKED_PAGE;
+	}
 
 	get_node_info(sbi, page->index, &ni);
 
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 081ef0d..b6015b7 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -278,6 +278,10 @@ static inline void fill_node_footer(struct page *page, nid_t nid,
 	/* should remain old flag bits such as COLD_BIT_SHIFT */
 	rn->footer.flag = cpu_to_le32((ofs << OFFSET_BIT_SHIFT) |
 					(old_flag & OFFSET_BIT_MASK));
+#ifdef CONFIG_F2FS_CHECK_FS
+	if (IN_INODE(page))
+		f2fs_inode_chksum_set(F2FS_P_SB(page), page);
+#endif
 }
 
 static inline void copy_node_footer(struct page *dst, struct page *src)
@@ -285,6 +289,10 @@ static inline void copy_node_footer(struct page *dst, struct page *src)
 	struct f2fs_node *src_rn = F2FS_NODE(src);
 	struct f2fs_node *dst_rn = F2FS_NODE(dst);
 	memcpy(&dst_rn->footer, &src_rn->footer, sizeof(struct node_footer));
+#ifdef CONFIG_F2FS_CHECK_FS
+	if (IN_INODE(dst))
+		f2fs_inode_chksum_set(F2FS_P_SB(dst), dst);
+#endif
 }
 
 static inline void fill_node_footer_blkaddr(struct page *page, block_t blkaddr)
@@ -298,6 +306,10 @@ static inline void fill_node_footer_blkaddr(struct page *page, block_t blkaddr)
 
 	rn->footer.cp_ver = cpu_to_le64(cp_ver);
 	rn->footer.next_blkaddr = cpu_to_le32(blkaddr);
+#ifdef CONFIG_F2FS_CHECK_FS
+	if (IN_INODE(page))
+		f2fs_inode_chksum_set(F2FS_P_SB(page), page);
+#endif
 }
 
 static inline bool is_recoverable_dnode(struct page *page)
@@ -364,6 +376,10 @@ static inline int set_nid(struct page *p, int off, nid_t nid, bool i)
 		rn->i.i_nid[off - NODE_DIR1_BLOCK] = cpu_to_le32(nid);
 	else
 		rn->in.nid[off] = cpu_to_le32(nid);
+#ifdef CONFIG_F2FS_CHECK_FS
+	if (IN_INODE(p))
+		f2fs_inode_chksum_set(F2FS_P_SB(p), p);
+#endif
 	return set_page_dirty(p);
 }
 
@@ -432,6 +448,10 @@ static inline void set_cold_node(struct inode *inode, struct page *page)
 	else
 		flag |= (0x1 << COLD_BIT_SHIFT);
 	rn->footer.flag = cpu_to_le32(flag);
+#ifdef CONFIG_F2FS_CHECK_FS
+	if (IN_INODE(page))
+		f2fs_inode_chksum_set(F2FS_I_SB(inode), page);
+#endif
 }
 
 static inline void set_mark(struct page *page, int mark, int type)
@@ -443,6 +463,10 @@ static inline void set_mark(struct page *page, int mark, int type)
 	else
 		flag &= ~(0x1 << type);
 	rn->footer.flag = cpu_to_le32(flag);
+#ifdef CONFIG_F2FS_CHECK_FS
+	if (IN_INODE(page))
+		f2fs_inode_chksum_set(F2FS_P_SB(page), page);
+#endif
 }
 #define set_dentry_mark(page, mark)	set_mark(page, mark, DENT_BIT_SHIFT)
 #define set_fsync_mark(page, mark)	set_mark(page, mark, FSYNC_BIT_SHIFT)
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index ae2dfa7..572bc17 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -424,6 +424,9 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 				return err;
 			}
 			memcpy(inline_addr, txattr_addr, inline_size);
+#ifdef CONFIG_F2FS_CHECK_FS
+			f2fs_inode_chksum_set(sbi, ipage ? ipage : in_page);
+#endif
 			set_page_dirty(ipage ? ipage : in_page);
 			goto in_page_out;
 		}
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
