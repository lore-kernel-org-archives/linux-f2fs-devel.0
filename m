From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs: missing REQ_META and REQ_PRIO when
 sync_meta_pages(META_FLUSH)
Date: Thu, 16 Jan 2014 11:58:54 +0900
Message-ID: <1389841134-25862-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Doing sync_meta_pages with META_FLUSH when checkpoint, we overide rw
using WRITE_FLUSH_FUA. At this time, we also should set
REQ_META|REQ_PRIO.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 63d1902..86772be 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -144,7 +144,7 @@ void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
 	/* change META to META_FLUSH in the checkpoint procedure */
 	if (type >= META_FLUSH) {
 		io->fio.type = META_FLUSH;
-		io->fio.rw = WRITE_FLUSH_FUA;
+		io->fio.rw = WRITE_FLUSH_FUA | REQ_META | REQ_PRIO;
 	}
 	__submit_merged_bio(io);
 	mutex_unlock(&io->io_mutex);
-- 
1.7.9.5

