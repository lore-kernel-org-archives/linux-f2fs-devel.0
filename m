From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/3] f2fs: recognize encrypted data in f2fs_fiemap
Date: Fri, 08 Jan 2016 20:19:27 +0800
Message-ID: <005901d14a0e$eb9c9480$c2d5bd80$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fixes to teach f2fs_fiemap to recognize encrypted data.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3001f9c..5249de8 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -833,9 +833,13 @@ next:
 		flags |= FIEMAP_EXTENT_LAST;
 	}
 
-	if (size)
+	if (size) {
+		if (f2fs_encrypted_inode(inode))
+			flags |= FIEMAP_EXTENT_DATA_ENCRYPTED;
+
 		ret = fiemap_fill_next_extent(fieinfo, logical,
 				phys, size, flags);
+	}
 
 	if (start_blk > last_blk || ret)
 		goto out;
-- 
2.6.3
