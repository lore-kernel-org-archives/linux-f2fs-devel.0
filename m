From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: plug readahead IO in readdir()
Date: Fri, 7 Sep 2018 19:49:07 +0800
Message-ID: <20180907114907.48740-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Add a plug to merge readahead IO in readdir(), expecting it can
reduce bio count before submitting to block layer.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index ecc3a4e2be96..bd0348cc860f 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -784,9 +784,15 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 	struct f2fs_dir_entry *de = NULL;
 	struct fscrypt_str de_name = FSTR_INIT(NULL, 0);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(d->inode);
+	struct blk_plug plug;
+	bool readdir_ra = sbi->readdir_ra == 1;
+	int err = 0;
 
 	bit_pos = ((unsigned long)ctx->pos % d->max);
 
+	if (readdir_ra)
+		blk_start_plug(&plug);
+
 	while (bit_pos < d->max) {
 		bit_pos = find_next_bit_le(d->bitmap, d->max, bit_pos);
 		if (bit_pos >= d->max)
@@ -806,29 +812,33 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 
 		if (f2fs_encrypted_inode(d->inode)) {
 			int save_len = fstr->len;
-			int err;
 
 			err = fscrypt_fname_disk_to_usr(d->inode,
 						(u32)de->hash_code, 0,
 						&de_name, fstr);
 			if (err)
-				return err;
+				goto out;
 
 			de_name = *fstr;
 			fstr->len = save_len;
 		}
 
 		if (!dir_emit(ctx, de_name.name, de_name.len,
-					le32_to_cpu(de->ino), d_type))
-			return 1;
+					le32_to_cpu(de->ino), d_type)) {
+			err = 1;
+			goto out;
+		}
 
-		if (sbi->readdir_ra == 1)
+		if (readdir_ra)
 			f2fs_ra_node_page(sbi, le32_to_cpu(de->ino));
 
 		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
 		ctx->pos = start_pos + bit_pos;
 	}
-	return 0;
+out:
+	if (readdir_ra)
+		blk_finish_plug(&plug);
+	return err;
 }
 
 static int f2fs_readdir(struct file *file, struct dir_context *ctx)
-- 
2.18.0.rc1
