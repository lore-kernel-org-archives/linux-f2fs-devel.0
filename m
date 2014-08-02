From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: avoid skipping recover_inline_xattr after
 recover_inline_data
Date: Sat, 02 Aug 2014 15:26:04 +0800
Message-ID: <021901cfae23$2afd3780$80f7a680$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XDTiz-0008Un-Uu
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 Aug 2014 07:27:29 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XDTix-0001G2-Lt
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 Aug 2014 07:27:29 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N9O00FBB4P2W9A0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 Aug 2014 16:27:02 +0900 (KST)
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

When we recover data of inode in roll-forward procedure, and the inode has both
inline data and inline xattr. We may skip recovering inline xattr if we recover
inline data form node page first.
This patch will fix the problem that we lost inline xattr data in above
scenario.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h     | 1 +
 fs/f2fs/node.c     | 4 +---
 fs/f2fs/recovery.c | 2 ++
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 14b9f74..9832279 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1204,6 +1204,7 @@ void alloc_nid_done(struct f2fs_sb_info *, nid_t);
 void alloc_nid_failed(struct f2fs_sb_info *, nid_t);
 void recover_node_page(struct f2fs_sb_info *, struct page *,
 		struct f2fs_summary *, struct node_info *, block_t);
+void recover_inline_xattr(struct inode *, struct page *);
 bool recover_xattr_data(struct inode *, struct page *, block_t);
 int recover_inode_page(struct f2fs_sb_info *, struct page *);
 int restore_node_summary(struct f2fs_sb_info *, unsigned int,
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index a90f51d..feba8c1 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1549,7 +1549,7 @@ void recover_node_page(struct f2fs_sb_info *sbi, struct page *page,
 	clear_node_page_dirty(page);
 }
 
-static void recover_inline_xattr(struct inode *inode, struct page *page)
+void recover_inline_xattr(struct inode *inode, struct page *page)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 	void *src_addr, *dst_addr;
@@ -1588,8 +1588,6 @@ bool recover_xattr_data(struct inode *inode, struct page *page, block_t blkaddr)
 	nid_t new_xnid = nid_of_node(page);
 	struct node_info ni;
 
-	recover_inline_xattr(inode, page);
-
 	if (!f2fs_has_xattr_block(ofs_of_node(page)))
 		return false;
 
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index b2aa53b..fe1c6d9 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -300,6 +300,8 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	struct node_info ni;
 	int err = 0, recovered = 0;
 
+	recover_inline_xattr(inode, page);
+
 	if (recover_inline_data(inode, page))
 		goto out;
 
-- 
2.0.1.474.g72c7794



------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
