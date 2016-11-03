From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/7] sload.f2fs: not support to find or add files
	in inline_dir directory
Date: Wed,  2 Nov 2016 22:28:44 -0700
Message-ID: <20161103052846.72244-5-jaegeuk@kernel.org>
References: <20161103052846.72244-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1c2AaS-00061S-RX
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 05:29:16 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c2AaS-0006ar-5V
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 05:29:16 +0000
In-Reply-To: <20161103052846.72244-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

Now, sload.f2fs doesn't support inline_dir.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/dir.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fsck/dir.c b/fsck/dir.c
index 18b79bd..2009855 100644
--- a/fsck/dir.c
+++ b/fsck/dir.c
@@ -185,6 +185,12 @@ static int f2fs_find_entry(struct f2fs_sb_info *sbi,
 	unsigned int max_depth;
 	unsigned int level;
 
+	if (dir->i.i_inline & F2FS_INLINE_DENTRY) {
+		ERR_MSG("Not support to find \"%s\" in inline_dir pino=%x\n",
+				de->name, de->pino);
+		return 0;
+	}
+
 	max_depth = dir->i.i_current_depth;
 	for (level = 0; level < max_depth; level ++) {
 		if (find_in_level(sbi, dir, level, de))
@@ -494,6 +500,13 @@ int f2fs_create(struct f2fs_sb_info *sbi, struct dentry *de)
 			de->ino = 0;
 		goto free_parent_dir;
 	}
+	if (parent->i.i_inline & F2FS_INLINE_DENTRY) {
+		ERR_MSG("Not support adding \"%s\" in inline_dir pino=%x\n",
+					de->name, de->pino);
+		if (de->file_type == F2FS_FT_REG_FILE)
+			de->ino = 0;
+		goto free_parent_dir;
+	}
 
 	child = calloc(BLOCK_SZ, 1);
 	ASSERT(child);
-- 
2.8.3


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
