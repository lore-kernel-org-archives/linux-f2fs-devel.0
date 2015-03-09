From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: [PATCH 1/3] f2fs: guarantee node/meta inode number won't be reused
Date: Mon,  9 Mar 2015 11:00:53 +0800
Message-ID: <1425870055-27694-1-git-send-email-wanpeng.li@linux.intel.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Changman Lee <cm224.lee@samsung.com>, Chao Yu <chao2.yu@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Wanpeng Li <wanpeng.li@linux.intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Node/Meta inode numbers are also should not be reused, this patch
guarantee it.

Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
---
 fs/f2fs/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4687eae..1a7e925 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1421,7 +1421,7 @@ static int add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
 		return -1;
 
 	/* 0 nid should not be used */
-	if (unlikely(nid == 0))
+	if (unlikely(nid == 0 || nid == 1 || nid == 2))
 		return 0;
 
 	if (build) {
-- 
1.9.1

