From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/4] f2fs: prevent checkpoint during roll-forward
Date: Fri, 15 Aug 2014 15:03:47 -0700
Message-ID: <1408140229-54949-2-git-send-email-jaegeuk@kernel.org>
References: <1408140229-54949-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XIPaR-0003KP-9i
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Aug 2014 22:03:03 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XIPaQ-0001JA-C1 for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Aug 2014 22:03:03 +0000
In-Reply-To: <1408140229-54949-1-git-send-email-jaegeuk@kernel.org>
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

Any checkpoint should not be done during the core roll-forward procedure.
Especially, it includes error cases too.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 7ca7aad..d36ef35 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -459,6 +459,9 @@ int recover_fsync_data(struct f2fs_sb_info *sbi)
 	/* step #1: find fsynced inode numbers */
 	sbi->por_doing = true;
 
+	/* prevent checkpoint */
+	mutex_lock(&sbi->cp_mutex);
+
 	blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
 
 	err = find_fsync_dnodes(sbi, &inode_list);
@@ -490,8 +493,13 @@ out:
 		/* Flush all the NAT/SIT pages */
 		while (get_pages(sbi, F2FS_DIRTY_META))
 			sync_meta_pages(sbi, META, LONG_MAX);
+		set_ckpt_flags(sbi->ckpt, CP_ERROR_FLAG);
+		mutex_unlock(&sbi->cp_mutex);
 	} else if (need_writecp) {
+		mutex_unlock(&sbi->cp_mutex);
 		write_checkpoint(sbi, false);
+	} else {
+		mutex_unlock(&sbi->cp_mutex);
 	}
 	return err;
 }
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
