From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: export FS_NOCOW_FL flag to user
Date: Fri, 4 Jan 2019 12:44:49 -0800
Message-ID: <20190104204449.GD57873@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190104041945.31802-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190104041945.31802-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

This exports pin_file status to user.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
v2:
 - use F2FS_NOCOW_FL (aka FS_NOCOW_FL)

 fs/f2fs/f2fs.h | 3 ++-
 fs/f2fs/file.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 12fabd6735dd..9286ec381453 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2301,11 +2301,12 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 #define F2FS_EXTENTS_FL			0x00080000 /* Inode uses extents */
 #define F2FS_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
 #define F2FS_EOFBLOCKS_FL		0x00400000 /* Blocks allocated beyond EOF */
+#define F2FS_NOCOW_FL			0x00800000 /* Do not cow file */
 #define F2FS_INLINE_DATA_FL		0x10000000 /* Inode has inline data. */
 #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
 #define F2FS_RESERVED_FL		0x80000000 /* reserved for ext4 lib */
 
-#define F2FS_FL_USER_VISIBLE		0x304BDFFF /* User visible flags */
+#define F2FS_FL_USER_VISIBLE		0x30CBDFFF /* User visible flags */
 #define F2FS_FL_USER_MODIFIABLE		0x204BC0FF /* User modifiable flags */
 
 /* Flags we can manipulate with through F2FS_IOC_FSSETXATTR */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ae2b45e75847..0d461321edfc 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1651,6 +1651,8 @@ static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
 		flags |= F2FS_ENCRYPT_FL;
 	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
 		flags |= F2FS_INLINE_DATA_FL;
+	if (is_inode_flag_set(inode, FI_PIN_FILE))
+		flags |= F2FS_NOCOW_FL;
 
 	flags &= F2FS_FL_USER_VISIBLE;
 
-- 
2.19.0.605.g01d371f741-goog
