From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 02/13] f2fs: make clear on test condition and
	return types
Date: Tue, 12 Aug 2014 12:49:16 -0700
Message-ID: <1407872967-26423-2-git-send-email-jaegeuk@kernel.org>
References: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XHI4U-000376-Cs
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Aug 2014 19:49:26 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XHI4S-0007Lu-Ch for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Aug 2014 19:49:26 +0000
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

This patch adds a parentheses to make clear for condition check.
And also it changes the return type for better meanings.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h   |  2 +-
 fs/f2fs/inline.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c8288c9..2e4aa3a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1442,5 +1442,5 @@ int f2fs_read_inline_data(struct inode *, struct page *);
 int f2fs_convert_inline_data(struct inode *, pgoff_t, struct page *);
 int f2fs_write_inline_data(struct inode *, struct page *, unsigned int);
 void truncate_inline_data(struct inode *, u64);
-int recover_inline_data(struct inode *, struct page *);
+bool recover_inline_data(struct inode *, struct page *);
 #endif
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 1ec512d..520758b 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -203,7 +203,7 @@ void truncate_inline_data(struct inode *inode, u64 from)
 	f2fs_put_page(ipage, 1);
 }
 
-int recover_inline_data(struct inode *inode, struct page *npage)
+bool recover_inline_data(struct inode *inode, struct page *npage)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 	struct f2fs_inode *ri = NULL;
@@ -222,7 +222,7 @@ int recover_inline_data(struct inode *inode, struct page *npage)
 		ri = F2FS_INODE(npage);
 
 	if (f2fs_has_inline_data(inode) &&
-			ri && ri->i_inline & F2FS_INLINE_DATA) {
+			ri && (ri->i_inline & F2FS_INLINE_DATA)) {
 process_inline:
 		ipage = get_node_page(sbi, inode->i_ino);
 		f2fs_bug_on(IS_ERR(ipage));
@@ -234,7 +234,7 @@ process_inline:
 		memcpy(dst_addr, src_addr, MAX_INLINE_DATA);
 		update_inode(inode, ipage);
 		f2fs_put_page(ipage, 1);
-		return -1;
+		return true;
 	}
 
 	if (f2fs_has_inline_data(inode)) {
@@ -246,10 +246,10 @@ process_inline:
 		clear_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
 		update_inode(inode, ipage);
 		f2fs_put_page(ipage, 1);
-	} else if (ri && ri->i_inline & F2FS_INLINE_DATA) {
+	} else if (ri && (ri->i_inline & F2FS_INLINE_DATA)) {
 		truncate_blocks(inode, 0);
 		set_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
 		goto process_inline;
 	}
-	return 0;
+	return false;
 }
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
