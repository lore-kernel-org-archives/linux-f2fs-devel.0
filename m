From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix sparse warning
Date: Tue, 28 May 2019 17:23:33 +0800
Message-ID: <20190528092333.42663-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

make C=2 CHECKFLAGS="-D__CHECK_ENDIAN__"

CHECK   dir.c
dir.c:842:50: warning: cast from restricted __le32
CHECK   node.c
node.c:2759:40: warning: restricted __le32 degrades to integer

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c  | 4 ++--
 fs/f2fs/node.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 59bc46017855..64cb61c42b95 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -828,8 +828,8 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			int save_len = fstr->len;
 
 			err = fscrypt_fname_disk_to_usr(d->inode,
-						(u32)de->hash_code, 0,
-						&de_name, fstr);
+						(u32)le32_to_cpu(de->hash_code),
+						0, &de_name, fstr);
 			if (err)
 				goto out;
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 18a038a2a9fa..865f1525df32 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2725,7 +2725,7 @@ static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
 		i = 1;
 	}
 	for (; i < NAT_ENTRY_PER_BLOCK; i++) {
-		if (nat_blk->entries[i].block_addr != NULL_ADDR)
+		if (le32_to_cpu(nat_blk->entries[i].block_addr) != NULL_ADDR)
 			valid++;
 	}
 	if (valid == 0) {
-- 
2.18.0.rc1
