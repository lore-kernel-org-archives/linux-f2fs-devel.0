From: Shuoran Liu <liushuoran@huawei.com>
Subject: [f2fs-dev] [PATCH] f2fs: fix a bug when using namehash to locate dentry bucket
Date: Thu, 25 Aug 2016 20:42:09 +0800
Message-ID: <1472128929-86774-1-git-send-email-liushuoran@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In the following scenario,

1) we don't have the key and doing a lookup for encrypted file,
2) and the encrypted filename is big name

we should use fname->hash as name hash value instead of what is
calculated by fname->disk_name. Because in such case,
fname->disk_name is empty.
---
 fs/f2fs/dir.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 9054aea..b3e6f7f 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -172,7 +172,10 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 	int max_slots;
 	f2fs_hash_t namehash;
 
-	namehash = f2fs_dentry_hash(&name);
+	if(fname->hash)
+		namehash = cpu_to_le32(fname->hash);
+	else
+		namehash = f2fs_dentry_hash(&name);
 
 	nbucket = dir_buckets(level, F2FS_I(dir)->i_dir_level);
 	nblock = bucket_blocks(level);
-- 
1.9.1
