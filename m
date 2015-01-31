From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] f2fs: don't discard next free dnode page for an umount
 checkpoint
Date: Sat, 31 Jan 2015 17:06:59 +0800
Message-ID: <008c01d03d35$62ceb7a0$286c26e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously, discard_next_dnode is added before a checkpoint to prevent that we
may meet a garbage dnode page readed from next free blkaddr in recover flow.

Since f2fs will skip recovery flow for a clean umount image, this condition will
never happen.

So it's safe for us to leave next free dnode as it is in an umount checkpoint.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f7cdcad..991fd0a 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -905,8 +905,12 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	/*
 	 * This avoids to conduct wrong roll-forward operations and uses
 	 * metapages, so should be called prior to sync_meta_pages below.
+	 * But if we are in an umount checkpoint, we'd better skip this
+	 * because we will not enter recovery flow to use the next free
+	 * blkaddr when mounting it.
 	 */
-	discard_next_dnode(sbi, NEXT_FREE_BLKADDR(sbi, curseg));
+	if (cpc->reason != CP_UMOUNT)
+		discard_next_dnode(sbi, NEXT_FREE_BLKADDR(sbi, curseg));
 
 	/* Flush all the NAT/SIT pages */
 	while (get_pages(sbi, F2FS_DIRTY_META)) {
-- 
2.2.1
