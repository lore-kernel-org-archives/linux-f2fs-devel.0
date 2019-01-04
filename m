From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: export pin_file flag to user
Date: Thu,  3 Jan 2019 20:19:45 -0800
Message-ID: <20190104041945.31802-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gfGxi-0004wJ-L2
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Jan 2019 04:19:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gfGxc-00ELk7-Eb
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Jan 2019 04:19:58 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This exports pin_file status to user.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 3 ++-
 fs/f2fs/file.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 12fabd6735dd..036fd62010c1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2303,9 +2303,10 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 #define F2FS_EOFBLOCKS_FL		0x00400000 /* Blocks allocated beyond EOF */
 #define F2FS_INLINE_DATA_FL		0x10000000 /* Inode has inline data. */
 #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
+#define F2FS_PIN_FILE_FL		0x40000000 /* pin_file status */
 #define F2FS_RESERVED_FL		0x80000000 /* reserved for ext4 lib */
 
-#define F2FS_FL_USER_VISIBLE		0x304BDFFF /* User visible flags */
+#define F2FS_FL_USER_VISIBLE		0x704BDFFF /* User visible flags */
 #define F2FS_FL_USER_MODIFIABLE		0x204BC0FF /* User modifiable flags */
 
 /* Flags we can manipulate with through F2FS_IOC_FSSETXATTR */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ae2b45e75847..eb099f1ee937 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1651,6 +1651,8 @@ static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
 		flags |= F2FS_ENCRYPT_FL;
 	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
 		flags |= F2FS_INLINE_DATA_FL;
+	if (is_inode_flag_set(inode, FI_PIN_FILE))
+		flags |= F2FS_PIN_FILE_FL;
 
 	flags &= F2FS_FL_USER_VISIBLE;
 
-- 
2.19.0.605.g01d371f741-goog
