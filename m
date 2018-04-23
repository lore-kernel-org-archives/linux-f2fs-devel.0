From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] fsck.f2fs: fix to avoid accessing invalid memory address
Date: Mon, 23 Apr 2018 14:01:45 +0800
Message-ID: <20180423060145.50324-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds to check return value of calloc in write_superblock().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/mount.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index 7e936dc056e5..badbe639742e 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -2155,6 +2155,7 @@ void write_superblock(struct f2fs_super_block *new_sb)
 	u_int8_t *buf;
 
 	buf = calloc(BLOCK_SZ, 1);
+	ASSERT(buf);
 
 	memcpy(buf + F2FS_SUPER_OFFSET, new_sb, sizeof(*new_sb));
 	for (index = 0; index < 2; index++) {
-- 
2.15.0.55.gc2ece9dc4de6
