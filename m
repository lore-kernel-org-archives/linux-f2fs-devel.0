From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/9] f2fs: add annotation for space utilization of
 regular/inline dentry
Date: Wed, 19 Aug 2015 19:02:02 +0800
Message-ID: <016d01d0da6e$a2d12e60$e8738b20$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Add annotation to let us know more clearly about space utilization
information of regular dentry and inline dentry.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 include/linux/f2fs_fs.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 920408a..25c6324 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -417,15 +417,25 @@ typedef __le32	f2fs_hash_t;
 
 #define GET_DENTRY_SLOTS(x)	((x + F2FS_SLOT_LEN - 1) >> F2FS_SLOT_LEN_BITS)
 
-/* the number of dentry in a block */
-#define NR_DENTRY_IN_BLOCK	214
-
 /* MAX level for dir lookup */
 #define MAX_DIR_HASH_DEPTH	63
 
 /* MAX buckets in one level of dir */
 #define MAX_DIR_BUCKETS		(1 << ((MAX_DIR_HASH_DEPTH / 2) - 1))
 
+/*
+ * space utilization of regular dentry and inline dentry
+ *		regular dentry			inline dentry
+ * bitmap	1 * 27 = 27			1 * 23 = 23
+ * reserved	1 * 3 = 3			1 * 7 = 7
+ * dentry	11 * 214 = 2354			11 * 182 = 2002
+ * filename	8 * 214 = 1712			8 * 182 = 1456
+ * total	4096				3488
+ *
+ * Note: there are more reserved space in inline dentry than in regular
+ * dentry, when converting inline dentry we should handle this carefully.
+ */
+#define NR_DENTRY_IN_BLOCK	214	/* the number of dentry in a block */
 #define SIZE_OF_DIR_ENTRY	11	/* by byte */
 #define SIZE_OF_DENTRY_BITMAP	((NR_DENTRY_IN_BLOCK + BITS_PER_BYTE - 1) / \
 					BITS_PER_BYTE)
-- 
2.4.2
