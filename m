From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: remove false-positive bug_on
Date: Fri, 26 May 2017 16:59:23 -0700
Message-ID: <20170526235923.31058-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1dEP8n-0000IH-79
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 May 2017 23:59:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dEP8m-0006YZ-8p
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 May 2017 23:59:33 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

If we got failure from both of create and evict_inode, we can hit this wrong
bug_on.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index e53c784ab11e..5673b0bd83b5 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -426,8 +426,6 @@ void f2fs_evict_inode(struct inode *inode)
 		alloc_nid_failed(sbi, inode->i_ino);
 		clear_inode_flag(inode, FI_FREE_NID);
 	}
-	f2fs_bug_on(sbi, err &&
-		!exist_written_data(sbi, inode->i_ino, ORPHAN_INO));
 out_clear:
 	fscrypt_put_encryption_info(inode, NULL);
 	clear_inode(inode);
-- 
2.13.0.rc1.294.g07d810a77f-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
