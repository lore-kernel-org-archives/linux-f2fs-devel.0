From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 05/13] f2fs: should clear the inline_xattr flag
Date: Tue, 12 Aug 2014 12:49:19 -0700
Message-ID: <1407872967-26423-5-git-send-email-jaegeuk@kernel.org>
References: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XHI4c-00037S-G7
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Aug 2014 19:49:34 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XHI4Y-0003TN-3W for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Aug 2014 19:49:34 +0000
In-Reply-To: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
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

During the recovery, we should clear the inline_xattr flag if its xattr node
block is recovered.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 093d799..151045f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1557,26 +1557,25 @@ void recover_inline_xattr(struct inode *inode, struct page *page)
 	struct page *ipage;
 	struct f2fs_inode *ri;
 
-	if (!f2fs_has_inline_xattr(inode))
-		return;
-
 	if (!IS_INODE(page))
 		return;
 
-	ri = F2FS_INODE(page);
-	if (!(ri->i_inline & F2FS_INLINE_XATTR))
-		return;
-
 	ipage = get_node_page(sbi, inode->i_ino);
 	f2fs_bug_on(IS_ERR(ipage));
 
+	ri = F2FS_INODE(page);
+	if (!(ri->i_inline & F2FS_INLINE_XATTR)) {
+		clear_inode_flag(F2FS_I(inode), FI_INLINE_XATTR);
+		goto update_inode;
+	}
+
 	dst_addr = inline_xattr_addr(ipage);
 	src_addr = inline_xattr_addr(page);
 	inline_size = inline_xattr_size(inode);
 
 	f2fs_wait_on_page_writeback(ipage, NODE);
 	memcpy(dst_addr, src_addr, inline_size);
-
+update_inode:
 	update_inode(inode, ipage);
 	f2fs_put_page(ipage, 1);
 }
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
