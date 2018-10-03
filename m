From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: allow to mount, if quota is failed
Date: Tue,  2 Oct 2018 18:27:25 -0700
Message-ID: <20181003012725.37670-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Since we can use the filesystem without quotas till next boot.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b39f60d57120..828a71a77799 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3282,11 +3282,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	/* Enable quota usage during mount */
 	if (f2fs_sb_has_quota_ino(sb) && !f2fs_readonly(sb)) {
 		err = f2fs_enable_quotas(sb);
-		if (err) {
+		if (err)
 			f2fs_msg(sb, KERN_ERR,
 				"Cannot turn on quotas: error %d", err);
-			goto free_sysfs;
-		}
 	}
 #endif
 	/* if there are nt orphan nodes free them */
@@ -3387,9 +3385,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	 * falls into an infinite loop in f2fs_sync_meta_pages().
 	 */
 	truncate_inode_pages_final(META_MAPPING(sbi));
-#ifdef CONFIG_QUOTA
-free_sysfs:
-#endif
 	f2fs_unregister_sysfs(sbi);
 free_root_inode:
 	dput(sb->s_root);
-- 
2.19.0.605.g01d371f741-goog
