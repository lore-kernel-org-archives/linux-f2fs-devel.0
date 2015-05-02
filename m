From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 08/19] f2fs: clean up f2fs_lookup
Date: Fri,  1 May 2015 17:48:35 -0700
Message-ID: <1430527726-68547-8-git-send-email-jaegeuk@kernel.org>
References: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YoLcP-0001Bk-Q0
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:21 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YoLcP-0004Sj-0v for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:21 +0000
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

This patch cleans up to avoid deep indentation.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 658e807..a311c3c 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -232,31 +232,32 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	struct inode *inode = NULL;
 	struct f2fs_dir_entry *de;
 	struct page *page;
+	nid_t ino;
 
 	if (dentry->d_name.len > F2FS_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
 	de = f2fs_find_entry(dir, &dentry->d_name, &page);
-	if (de) {
-		nid_t ino = le32_to_cpu(de->ino);
-		f2fs_dentry_kunmap(dir, page);
-		f2fs_put_page(page, 0);
+	if (!de)
+		return d_splice_alias(inode, dentry);
 
-		inode = f2fs_iget(dir->i_sb, ino);
-		if (IS_ERR(inode))
-			return ERR_CAST(inode);
+	ino = le32_to_cpu(de->ino);
+	f2fs_dentry_kunmap(dir, page);
+	f2fs_put_page(page, 0);
 
-		if (f2fs_has_inline_dots(inode)) {
-			int err;
+	inode = f2fs_iget(dir->i_sb, ino);
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+
+	if (f2fs_has_inline_dots(inode)) {
+		int err;
 
-			err = __recover_dot_dentries(inode, dir->i_ino);
-			if (err) {
-				iget_failed(inode);
-				return ERR_PTR(err);
-			}
+		err = __recover_dot_dentries(inode, dir->i_ino);
+		if (err) {
+			iget_failed(inode);
+			return ERR_PTR(err);
 		}
 	}
-
 	return d_splice_alias(inode, dentry);
 }
 
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
