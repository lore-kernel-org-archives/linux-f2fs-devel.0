From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 11/11] f2fs: retry to truncate blocks in -ENOMEM
	case
Date: Tue,  3 May 2016 11:21:48 -0700
Message-ID: <1462299708-67906-11-git-send-email-jaegeuk@kernel.org>
References: <1462299708-67906-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1axexb-0005zz-Mj
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 May 2016 18:22:15 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1axexb-0002mN-23
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 May 2016 18:22:15 +0000
In-Reply-To: <1462299708-67906-1-git-send-email-jaegeuk@kernel.org>
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

This patch modifies to retry truncating node blocks in -ENOMEM case.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index f4ac851..5cccd7a 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -344,7 +344,7 @@ void f2fs_evict_inode(struct inode *inode)
 	sb_start_intwrite(inode->i_sb);
 	set_inode_flag(fi, FI_NO_ALLOC);
 	i_size_write(inode, 0);
-
+retry:
 	if (F2FS_HAS_BLOCKS(inode))
 		err = f2fs_truncate(inode, true);
 
@@ -374,6 +374,11 @@ no_delete:
 
 	if (err && err != -ENOENT) {
 		if (!exist_written_data(sbi, inode->i_ino, ORPHAN_INO)) {
+			/* give more chances, if ENOMEM case */
+			if (err == -ENOMEM) {
+				err = 0;
+				goto retry;
+			}
 			/*
 			 * get here because we failed to release resource
 			 * of inode previously, reminder our user to run fsck
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
