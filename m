From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 3/6] f2fs: fix to avoid race condition when updating sbi flag
Date: Tue, 20 Sep 2016 10:29:47 +0800
Message-ID: <20160920022947.129803-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Making updating of sbi flag atomic by using {test,set,clear}_bit,
otherwise in concurrency scenario, the flag could be updated incorrectly.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9b4bbf2..fc57794 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -794,7 +794,7 @@ struct f2fs_sb_info {
 	struct proc_dir_entry *s_proc;		/* proc entry */
 	struct f2fs_super_block *raw_super;	/* raw super block pointer */
 	int valid_super_block;			/* valid super block no */
-	int s_flag;				/* flags for sbi */
+	unsigned long s_flag;				/* flags for sbi */
 
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
 	u8 key_prefix[F2FS_KEY_DESC_PREFIX_SIZE];
@@ -1063,17 +1063,17 @@ static inline struct address_space *NODE_MAPPING(struct f2fs_sb_info *sbi)
 
 static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
 {
-	return sbi->s_flag & (0x01 << type);
+	return test_bit(type, &sbi->s_flag);
 }
 
 static inline void set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
 {
-	sbi->s_flag |= (0x01 << type);
+	set_bit(type, &sbi->s_flag);
 }
 
 static inline void clear_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
 {
-	sbi->s_flag &= ~(0x01 << type);
+	clear_bit(type, &sbi->s_flag);
 }
 
 static inline unsigned long long cur_cp_version(struct f2fs_checkpoint *cp)
-- 
2.8.2.311.gee88674
