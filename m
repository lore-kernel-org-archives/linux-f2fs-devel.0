From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 07/13] f2fs: avoid bug_on when error is occurred
Date: Tue, 12 Aug 2014 12:49:21 -0700
Message-ID: <1407872967-26423-7-git-send-email-jaegeuk@kernel.org>
References: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XHI4e-00042D-Hg
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Aug 2014 19:49:36 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XHI4d-00009b-L0 for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Aug 2014 19:49:36 +0000
In-Reply-To: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
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

During the recovery, if an error like EIO or ENOMEM, f2fs_bug_on should skip.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index d7b67b8..7ca7aad 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -472,7 +472,8 @@ int recover_fsync_data(struct f2fs_sb_info *sbi)
 
 	/* step #2: recover data */
 	err = recover_data(sbi, &inode_list, CURSEG_WARM_NODE);
-	f2fs_bug_on(!list_empty(&inode_list));
+	if (!err)
+		f2fs_bug_on(!list_empty(&inode_list));
 out:
 	destroy_fsync_dnodes(&inode_list);
 	kmem_cache_destroy(fsync_entry_slab);
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
