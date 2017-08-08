From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: use IPU for cold files
Date: Mon,  7 Aug 2017 18:42:21 -0700
Message-ID: <20170808014222.31097-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

We expect cold files write data sequentially, but sometimes some of small data
can be updated, which incurs fragmentation.
Let's avoid that.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 6b871b492fd5..7f700e54b77d 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -577,6 +577,10 @@ static inline bool need_inplace_update_policy(struct inode *inode,
 	if (test_opt(sbi, LFS))
 		return false;
 
+	/* if this is cold file, we should overwrite to avoid fragmentation */
+	if (file_is_cold(inode))
+		return true;
+
 	if (policy & (0x1 << F2FS_IPU_FORCE))
 		return true;
 	if (policy & (0x1 << F2FS_IPU_SSR) && need_SSR(sbi))
-- 
2.13.0.rc1.294.g07d810a77f-goog
