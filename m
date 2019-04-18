From: Bharath Vedartham <linux.bhar@gmail.com>
Subject: [PATCH] f2fs: Force type conversion from __le32 to u32
Date: Thu, 18 Apr 2019 13:05:10 +0530
Message-ID: <20190418073510.GA11396@bharath12345-Inspiron-5559>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux.bhar@gmail.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch forces type conversion from __le32 to u32 to prevent sparse
warnings like:
warning: restricted __le32 degrades to integer

dir.c:
fscrypt_fname_disk_to_usr takes a hash of type u32 as it's second arg
but de->hash_code is of type __le32.

node.c
NULL_ADDR is of type u32 but block_addr is of type __le32.

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 fs/f2fs/dir.c  | 2 +-
 fs/f2fs/node.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 59bc460..4f39872 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -828,7 +828,7 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			int save_len = fstr->len;
 
 			err = fscrypt_fname_disk_to_usr(d->inode,
-						(u32)de->hash_code, 0,
+						(__force u32)de->hash_code, 0,
 						&de_name, fstr);
 			if (err)
 				goto out;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3f99ab2..9e333a5 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2706,7 +2706,7 @@ static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
 		i = 1;
 	}
 	for (; i < NAT_ENTRY_PER_BLOCK; i++) {
-		if (nat_blk->entries[i].block_addr != NULL_ADDR)
+		if ((__force u32)nat_blk->entries[i].block_addr != NULL_ADDR)
 			valid++;
 	}
 	if (valid == 0) {
-- 
2.7.4
