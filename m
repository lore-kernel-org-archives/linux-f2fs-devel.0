From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 18/18] f2fs crypto: remove checking key context
	during lookup
Date: Fri,  8 May 2015 21:20:53 -0700
Message-ID: <1431145253-2019-18-git-send-email-jaegeuk@kernel.org>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YqwGu-0002ZB-Q1
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:52 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqwGu-0003so-37 for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:52 +0000
In-Reply-To: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
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

No matter what the key is valid or not, readdir shows the dir entries correctly.
So, lookup should not failed.
But, we expect further accesses should be denied from open, rename, link, and so
on.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index e6a6310..cbedf56 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -260,16 +260,6 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-	if (f2fs_encrypted_inode(dir) && f2fs_may_encrypt(inode) &&
-		!f2fs_is_child_context_consistent_with_parent(dir, inode)) {
-		iput(inode);
-		f2fs_msg(inode->i_sb, KERN_WARNING,
-				"Inconsistent encryption contexts: %lu/%lu\n",
-				(unsigned long)dir->i_ino,
-				(unsigned long)inode->i_ino);
-		return ERR_PTR(-EPERM);
-	}
-
 	if (f2fs_has_inline_dots(inode)) {
 		err = __recover_dot_dentries(inode, dir->i_ino);
 		if (err)
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
