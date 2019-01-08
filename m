From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to trigger fsck if dirent.name_len is zero
Date: Tue, 8 Jan 2019 10:21:24 +0800
Message-ID: <20190108022124.33447-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

While traversing dirents in f2fs_fill_dentries(), if bitmap is valid,
filename length should not be zero, otherwise, directory structure
consistency could be corrupted, in this case, let's print related
info and set SBI_NEED_FSCK to trigger fsck for repairing.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 50d0d36280fa..926166528cd4 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -800,6 +800,10 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 		if (de->name_len == 0) {
 			bit_pos++;
 			ctx->pos = start_pos + bit_pos;
+			printk_ratelimited(
+				"%s, invalid namelen(0), ino:%u, run fsck to fix.",
+				KERN_WARNING, le32_to_cpu(de->ino));
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			continue;
 		}
 
-- 
2.18.0.rc1
