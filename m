From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: turn quota off when error occurs
Date: Fri, 20 Oct 2017 08:53:37 -0700
Message-ID: <20171020155337.5354-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Before changing readonly, it needs to turn quota off.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 201608281681..ff74665d7f2d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -29,6 +29,7 @@ struct kmem_cache *inode_entry_slab;
 void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
 {
 	set_ckpt_flags(sbi, CP_ERROR_FLAG);
+	f2fs_quota_off_umount(sb);
 	sbi->sb->s_flags |= MS_RDONLY;
 	if (!end_io)
 		f2fs_flush_merged_writes(sbi);
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
