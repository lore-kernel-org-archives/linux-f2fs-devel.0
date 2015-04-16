From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: avoid abnormal behavior on broken
	symlink
Date: Thu, 16 Apr 2015 00:30:44 -0700
Message-ID: <1429169445-18306-2-git-send-email-jaegeuk@kernel.org>
References: <1429169445-18306-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YieGF-0001J1-Md
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Apr 2015 07:30:55 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YieGE-0006t4-PT for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Apr 2015 07:30:55 +0000
In-Reply-To: <1429169445-18306-1-git-send-email-jaegeuk@kernel.org>
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

When f2fs_symlink was triggered and checkpoint was done before syncing its
link path, f2fs can get broken symlink like "xxx -> \0\0\0".
This incurs abnormal path_walk by VFS.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 5d990d8..6cfd954 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -14,6 +14,7 @@
 #include <linux/sched.h>
 #include <linux/ctype.h>
 #include <linux/dcache.h>
+#include <linux/namei.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -295,6 +296,23 @@ fail:
 	return err;
 }
 
+static void *f2fs_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	struct page *page;
+
+	page = page_follow_link_light(dentry, nd);
+	if (IS_ERR(page))
+		return page;
+
+	/* this is broken symlink case */
+	if (*nd_get_link(nd) == 0) {
+		kunmap(page);
+		page_cache_release(page);
+		return ERR_PTR(-ENOENT);
+	}
+	return page;
+}
+
 static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 					const char *symname)
 {
@@ -790,7 +808,7 @@ const struct inode_operations f2fs_dir_inode_operations = {
 
 const struct inode_operations f2fs_symlink_inode_operations = {
 	.readlink       = generic_readlink,
-	.follow_link    = page_follow_link_light,
+	.follow_link    = f2fs_follow_link,
 	.put_link       = page_put_link,
 	.getattr	= f2fs_getattr,
 	.setattr	= f2fs_setattr,
-- 
2.1.1


------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
