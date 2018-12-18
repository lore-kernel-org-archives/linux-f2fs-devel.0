From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: clean up structure extent_node
Date: Tue, 18 Dec 2018 19:20:16 +0800
Message-ID: <20181218112017.80555-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

The union in struct extent_node wass only to indicate below fields

	struct rb_node rb_node;
	union {
		struct {
			unsigned int fofs;
			unsigned int len;
		...
	...

can be parsed as fields in struct rb_entry, but they were never be
used explicitly before, so let's remove them for cleanup.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ab69c7454a05..a92e5ed78f53 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -559,16 +559,8 @@ struct extent_info {
 };
 
 struct extent_node {
-	struct rb_node rb_node;
-	union {
-		struct {
-			unsigned int fofs;
-			unsigned int len;
-			u32 blk;
-		};
-		struct extent_info ei;	/* extent info */
-
-	};
+	struct rb_node rb_node;		/* rb node located in rb-tree */
+	struct extent_info ei;		/* extent info */
 	struct list_head list;		/* node in global extent list of sbi */
 	struct extent_tree *et;		/* extent tree pointer */
 };
-- 
2.18.0.rc1
