From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: submit bio after shutdown
Date: Fri,  7 Sep 2018 14:28:04 -0700
Message-ID: <20180907212804.91462-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Sometimes, some merged IOs could get a chance to be submitted, resulting in
system hang in shutdown test. This issues IOs all the time after shutdown.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8c204f896c22..26f38b224bb2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -533,6 +533,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	if (fio->in_list)
 		goto next;
 out:
+	if (is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN))
+		__submit_merged_bio(io);
 	up_write(&io->io_rwsem);
 }
 
-- 
2.17.0.441.gb46fe60e1d-goog
