From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: put directory inodes before checkpoint
	in roll-forward recovery
Date: Mon, 19 Sep 2016 19:55:04 -0700
Message-ID: <20160920025504.72524-2-jaegeuk@kernel.org>
References: <20160920025504.72524-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bmBDI-0008RI-UD
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 20 Sep 2016 02:55:16 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bmBDI-00078f-72
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 20 Sep 2016 02:55:16 +0000
In-Reply-To: <20160920025504.72524-1-jaegeuk@kernel.org>
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

Before checkpoint, we'd be better drop any inodes.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 2b8a56d..509273a 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -630,6 +630,9 @@ out:
 		set_ckpt_flags(sbi->ckpt, CP_ERROR_FLAG);
 	mutex_unlock(&sbi->cp_mutex);
 
+	/* let's drop all the directory inodes for clean checkpoint */
+	destroy_fsync_dnodes(&dir_list);
+
 	if (!err && need_writecp) {
 		struct cp_control cpc = {
 			.reason = CP_RECOVERY,
@@ -637,7 +640,6 @@ out:
 		err = write_checkpoint(sbi, &cpc);
 	}
 
-	destroy_fsync_dnodes(&dir_list);
 	kmem_cache_destroy(fsync_entry_slab);
 	return ret ? ret: err;
 }
-- 
2.8.3


------------------------------------------------------------------------------
