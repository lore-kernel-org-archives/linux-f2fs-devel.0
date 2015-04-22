From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix wrong error hanlder in f2fs_follow_link
Date: Wed, 22 Apr 2015 11:15:11 -0700
Message-ID: <1429726511-89192-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YkzBF-0000Jy-BO
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Apr 2015 18:15:25 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YkzBE-0004tf-6h for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Apr 2015 18:15:25 +0000
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

The page_follow_link_light returns NULL and its error pointer was remained
in nd->path.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 407dde3..1350755 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -298,16 +298,14 @@ fail:
 
 static void *f2fs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
-	struct page *page;
+	struct page *page = page_follow_link_light(dentry, nd);
 
-	page = page_follow_link_light(dentry, nd);
-	if (IS_ERR(page))
+	if (IS_ERR_OR_NULL(page))
 		return page;
 
 	/* this is broken symlink case */
 	if (*nd_get_link(nd) == 0) {
-		kunmap(page);
-		page_cache_release(page);
+		page_put_link(dentry, nd, page);
 		return ERR_PTR(-ENOENT);
 	}
 	return page;
-- 
2.1.1


------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
