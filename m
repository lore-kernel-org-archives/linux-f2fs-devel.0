From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/5] f2fs: go out for insert_inode_locked failure
Date: Tue, 18 Aug 2015 01:46:28 -0700
Message-ID: <1439887589-35190-4-git-send-email-jaegeuk@kernel.org>
References: <1439887589-35190-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZRcXY-0004jt-4v
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Aug 2015 08:46:40 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZRcXX-0003VJ-H8 for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Aug 2015 08:46:40 +0000
In-Reply-To: <1439887589-35190-1-git-send-email-jaegeuk@kernel.org>
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

We should not call unlock_new_inode when insert_inode_locked failed.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 97e97c4..a680bf3 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -53,7 +53,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	if (err) {
 		err = -EINVAL;
 		nid_free = true;
-		goto out;
+		goto fail;
 	}
 
 	/* If the directory encrypted, then we should encrypt the inode. */
@@ -75,9 +75,6 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	mark_inode_dirty(inode);
 	return inode;
 
-out:
-	clear_nlink(inode);
-	unlock_new_inode(inode);
 fail:
 	trace_f2fs_new_inode(inode, err);
 	make_bad_inode(inode);
-- 
2.1.1


------------------------------------------------------------------------------
