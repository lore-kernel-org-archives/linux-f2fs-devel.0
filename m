From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] fsck.f2fs: fix to do sanity check with
 inode.i_inline_xattr_size
Date: Mon, 4 Mar 2019 17:21:37 +0800
Message-ID: <20190304092137.121658-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1h0jnU-0006PX-BA
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Mar 2019 09:22:08 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h0jnT-009oxN-5H
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Mar 2019 09:22:09 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org

This patch adds to do sanity check with inode.i_inline_xattr_size,
and once it is corrupted, recover it to default value.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- fix incorrect definition of MAX_INLINE_XATTR_SIZE
- fix wrong condition of sanity check
 fsck/fsck.c       | 19 +++++++++++++++++++
 fsck/xattr.h      |  5 +++++
 include/f2fs_fs.h |  1 +
 3 files changed, 25 insertions(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index f408f0db50c0..0eb97426b442 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -9,6 +9,7 @@
  * published by the Free Software Foundation.
  */
 #include "fsck.h"
+#include "xattr.h"
 #include "quotaio.h"
 #include <time.h>
 
@@ -748,6 +749,24 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 			node_blk->i.i_inline &= ~F2FS_EXTRA_ATTR;
 			need_fix = 1;
 		}
+
+		if ((c.feature &
+			cpu_to_le32(F2FS_FEATURE_FLEXIBLE_INLINE_XATTR)) &&
+			(node_blk->i.i_inline & F2FS_INLINE_XATTR)) {
+			unsigned int inline_size =
+				le16_to_cpu(node_blk->i.i_inline_xattr_size);
+
+			if (!inline_size ||
+					inline_size > MAX_INLINE_XATTR_SIZE) {
+				FIX_MSG("ino[0x%x] recover inline xattr size "
+					"from %u to %u",
+					nid, inline_size,
+					DEFAULT_INLINE_XATTR_ADDRS);
+				node_blk->i.i_inline_xattr_size =
+					cpu_to_le16(DEFAULT_INLINE_XATTR_ADDRS);
+				need_fix = 1;
+			}
+		}
 	}
 	ofs = get_extra_isize(node_blk);
 
diff --git a/fsck/xattr.h b/fsck/xattr.h
index e4a98e224a93..dc80fafc04cb 100644
--- a/fsck/xattr.h
+++ b/fsck/xattr.h
@@ -134,4 +134,9 @@ static inline int f2fs_acl_count(int size)
 		sizeof(struct f2fs_xattr_header) -		\
 		sizeof(struct f2fs_xattr_entry))
 
+#define MAX_INLINE_XATTR_SIZE						\
+			(DEF_ADDRS_PER_INODE -				\
+			F2FS_TOTAL_EXTRA_ATTR_SIZE / sizeof(__le32) -	\
+			DEF_INLINE_RESERVED_SIZE -			\
+			MIN_INLINE_DENTRY_SIZE / sizeof(__le32))
 #endif
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index a73068887a82..3f8d9fb60740 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1069,6 +1069,7 @@ typedef __le32	f2fs_hash_t;
 #define SIZE_OF_RESERVED	(PAGE_SIZE - ((SIZE_OF_DIR_ENTRY + \
 				F2FS_SLOT_LEN) * \
 				NR_DENTRY_IN_BLOCK + SIZE_OF_DENTRY_BITMAP))
+#define MIN_INLINE_DENTRY_SIZE		40	/* just include '.' and '..' entries */
 
 /* One directory entry slot representing F2FS_SLOT_LEN-sized file name */
 struct f2fs_dir_entry {
-- 
2.18.0.rc1
