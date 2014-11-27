From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs: move put_gc_inode into gc_mutex
Date: Thu, 27 Nov 2014 18:42:54 +0900
Message-ID: <1417081374-31626-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

There in no any lock to protect gc_inode list so let's move into
gc_mutex, otherwise it might be lost links of list.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 657683c9..99e1720 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -733,9 +733,9 @@ gc_more:
 	if (gc_type == FG_GC)
 		write_checkpoint(sbi, &cpc);
 stop:
-	mutex_unlock(&sbi->gc_mutex);
-
 	put_gc_inode(&ilist);
+
+	mutex_unlock(&sbi->gc_mutex);
 	return ret;
 }
 
-- 
1.9.1

