From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 03/19] f2fs: move existing definitions into f2fs.h
Date: Fri,  1 May 2015 17:48:30 -0700
Message-ID: <1430527726-68547-3-git-send-email-jaegeuk@kernel.org>
References: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YoLcJ-0001dY-Op
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:15 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YoLcH-0001Cj-HR for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:15 +0000
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

This patch moves some inode-related definitions from node.h to f2fs.h to
add new features.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 22 ++++++++++++++++++++++
 fs/f2fs/node.h | 22 ----------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8be6cab..cd9748a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -320,6 +320,13 @@ struct extent_tree {
 #define FADVISE_COLD_BIT	0x01
 #define FADVISE_LOST_PINO_BIT	0x02
 
+#define file_is_cold(inode)	is_file(inode, FADVISE_COLD_BIT)
+#define file_wrong_pino(inode)	is_file(inode, FADVISE_LOST_PINO_BIT)
+#define file_set_cold(inode)	set_file(inode, FADVISE_COLD_BIT)
+#define file_lost_pino(inode)	set_file(inode, FADVISE_LOST_PINO_BIT)
+#define file_clear_cold(inode)	clear_file(inode, FADVISE_COLD_BIT)
+#define file_got_pino(inode)	clear_file(inode, FADVISE_LOST_PINO_BIT)
+
 #define DEF_DIR_LEVEL		0
 
 struct f2fs_inode_info {
@@ -1391,6 +1398,21 @@ static inline void f2fs_dentry_kunmap(struct inode *dir, struct page *page)
 		kunmap(page);
 }
 
+static inline int is_file(struct inode *inode, int type)
+{
+	return F2FS_I(inode)->i_advise & type;
+}
+
+static inline void set_file(struct inode *inode, int type)
+{
+	F2FS_I(inode)->i_advise |= type;
+}
+
+static inline void clear_file(struct inode *inode, int type)
+{
+	F2FS_I(inode)->i_advise &= ~type;
+}
+
 static inline int f2fs_readonly(struct super_block *sb)
 {
 	return sb->s_flags & MS_RDONLY;
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index c56026f..7427e95 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -343,28 +343,6 @@ static inline nid_t get_nid(struct page *p, int off, bool i)
  *  - Mark cold node blocks in their node footer
  *  - Mark cold data pages in page cache
  */
-static inline int is_file(struct inode *inode, int type)
-{
-	return F2FS_I(inode)->i_advise & type;
-}
-
-static inline void set_file(struct inode *inode, int type)
-{
-	F2FS_I(inode)->i_advise |= type;
-}
-
-static inline void clear_file(struct inode *inode, int type)
-{
-	F2FS_I(inode)->i_advise &= ~type;
-}
-
-#define file_is_cold(inode)	is_file(inode, FADVISE_COLD_BIT)
-#define file_wrong_pino(inode)	is_file(inode, FADVISE_LOST_PINO_BIT)
-#define file_set_cold(inode)	set_file(inode, FADVISE_COLD_BIT)
-#define file_lost_pino(inode)	set_file(inode, FADVISE_LOST_PINO_BIT)
-#define file_clear_cold(inode)	clear_file(inode, FADVISE_COLD_BIT)
-#define file_got_pino(inode)	clear_file(inode, FADVISE_LOST_PINO_BIT)
-
 static inline int is_cold_data(struct page *page)
 {
 	return PageChecked(page);
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
