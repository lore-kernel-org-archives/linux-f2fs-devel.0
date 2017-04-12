From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: give time to flush dirty pages for
	checkpoint
Date: Wed, 12 Apr 2017 14:21:19 -0700
Message-ID: <20170412212121.17693-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cyPhi-0007gH-Ap
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Apr 2017 21:21:30 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cyPhh-000109-ME
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Apr 2017 21:21:30 +0000
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

If all the threads are waiting for checkpoint, we have no chance to flush
required dirty pages.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 9db92990f193..800be94f8cb3 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -980,6 +980,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
 		err = sync_dirty_inodes(sbi, DIR_INODE);
 		if (err)
 			goto out;
+		cond_resched();
 		goto retry_flush_dents;
 	}
 
@@ -995,6 +996,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
 		err = f2fs_sync_inode_meta(sbi);
 		if (err)
 			goto out;
+		cond_resched();
 		goto retry_flush_dents;
 	}
 
@@ -1009,6 +1011,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
 			f2fs_unlock_all(sbi);
 			goto out;
 		}
+		cond_resched();
 		goto retry_flush_nodes;
 	}
 
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
