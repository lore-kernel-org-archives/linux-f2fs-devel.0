From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 09/19] f2fs: add f2fs_may_inline_{data, dentry}
Date: Fri,  1 May 2015 17:48:36 -0700
Message-ID: <1430527726-68547-9-git-send-email-jaegeuk@kernel.org>
References: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YoLcX-0001eE-9G
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:29 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YoLcW-0004Sy-Dy for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:29 +0000
In-Reply-To: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
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

This patch adds f2fs_may_inline_data and f2fs_may_inline_dentry.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h   |  3 ++-
 fs/f2fs/file.c   |  2 +-
 fs/f2fs/inline.c | 13 ++++++++++++-
 fs/f2fs/namei.c  |  4 ++--
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7ff3ac7..2bb9b57 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1839,7 +1839,8 @@ extern struct kmem_cache *inode_entry_slab;
 /*
  * inline.c
  */
-bool f2fs_may_inline(struct inode *);
+bool f2fs_may_inline_data(struct inode *);
+bool f2fs_may_inline_dentry(struct inode *);
 void read_inline_data(struct page *, struct page *);
 bool truncate_inline_inode(struct page *, u64);
 int f2fs_read_inline_data(struct inode *, struct page *);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3d6de54..ffd9b7e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -560,7 +560,7 @@ void f2fs_truncate(struct inode *inode)
 	trace_f2fs_truncate(inode);
 
 	/* we should check inline_data size */
-	if (f2fs_has_inline_data(inode) && !f2fs_may_inline(inode)) {
+	if (f2fs_has_inline_data(inode) && !f2fs_may_inline_data(inode)) {
 		if (f2fs_convert_inline_inode(inode))
 			return;
 	}
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 8140e4f..99d5148 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -13,7 +13,7 @@
 
 #include "f2fs.h"
 
-bool f2fs_may_inline(struct inode *inode)
+bool f2fs_may_inline_data(struct inode *inode)
 {
 	if (!test_opt(F2FS_I_SB(inode), INLINE_DATA))
 		return false;
@@ -30,6 +30,17 @@ bool f2fs_may_inline(struct inode *inode)
 	return true;
 }
 
+bool f2fs_may_inline_dentry(struct inode *inode)
+{
+	if (!test_opt(F2FS_I_SB(inode), INLINE_DENTRY))
+		return false;
+
+	if (!S_ISDIR(inode->i_mode))
+		return false;
+
+	return true;
+}
+
 void read_inline_data(struct page *page, struct page *ipage)
 {
 	void *src_addr, *dst_addr;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a311c3c..c0ba8e3 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -56,9 +56,9 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 		goto out;
 	}
 
-	if (f2fs_may_inline(inode))
+	if (f2fs_may_inline_data(inode))
 		set_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
-	if (test_opt(sbi, INLINE_DENTRY) && S_ISDIR(inode->i_mode))
+	if (f2fs_may_inline_dentry(inode))
 		set_inode_flag(F2FS_I(inode), FI_INLINE_DENTRY);
 
 	trace_f2fs_new_inode(inode, 0);
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
