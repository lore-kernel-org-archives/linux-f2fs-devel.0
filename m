From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: report error for f2fs_parent_dir
Date: Fri, 10 Jun 2016 14:01:07 -0700
Message-ID: <20160610210107.74181-2-jaegeuk@kernel.org>
References: <20160610210107.74181-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bBTYL-00005n-Qk
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Jun 2016 21:01:17 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bBTYL-0002PN-3Q
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Jun 2016 21:01:17 +0000
In-Reply-To: <20160610210107.74181-1-jaegeuk@kernel.org>
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

If there is no dentry, we can report its error correctly.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 78efe00..618829e 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -662,10 +662,11 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto out;
 
 	if (S_ISDIR(old_inode->i_mode)) {
-		err = -EIO;
 		old_dir_entry = f2fs_parent_dir(old_inode, &old_dir_page);
-		if (!old_dir_entry)
+		if (!old_dir_entry) {
+			err = PTR_ERR(old_dir_page);
 			goto out_old;
+		}
 	}
 
 	if (flags & RENAME_WHITEOUT) {
@@ -838,19 +839,21 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	/* prepare for updating ".." directory entry info later */
 	if (old_dir != new_dir) {
 		if (S_ISDIR(old_inode->i_mode)) {
-			err = -EIO;
 			old_dir_entry = f2fs_parent_dir(old_inode,
 							&old_dir_page);
-			if (!old_dir_entry)
+			if (!old_dir_entry) {
+				err = PTR_ERR(old_dir_page);
 				goto out_new;
+			}
 		}
 
 		if (S_ISDIR(new_inode->i_mode)) {
-			err = -EIO;
 			new_dir_entry = f2fs_parent_dir(new_inode,
 							&new_dir_page);
-			if (!new_dir_entry)
+			if (!new_dir_entry) {
+				err = PTR_ERR(new_dir_page);
 				goto out_old_dir;
+			}
 		}
 	}
 
-- 
2.8.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
