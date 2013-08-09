From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/3] f2fs: fix inconsistency between xattr node
 blocks and its inode
Date: Fri, 09 Aug 2013 15:20:29 +0900
Message-ID: <1376029230-303-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1376029230-303-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1V7g4W-0000q4-81
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 09 Aug 2013 06:21:12 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V7g4U-0001yF-Em for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 09 Aug 2013 06:21:12 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MR900KYX2Z1YL60@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 09 Aug 2013 15:21:01 +0900 (KST)
In-reply-to: <1376029230-303-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Previously xattr node blocks are stored to the COLD_NODE log, which means that
our roll-forward mechanism doesn't recover the xattr node blocks at all.
Only the direct node blocks in the WARM_NODE log can be recovered.

So, let's resolve the issue simply by conducting checkpoint during fsync when a
file has a modified xattr node block.

This approach is able to degrade the performance, but normally the checkpoint
overhead is shown at the initial fsync call after the xattr entry changes.
Once the checkpoint is done, no additional overhead would be occurred.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h  | 1 +
 fs/f2fs/file.c  | 3 +++
 fs/f2fs/xattr.c | 4 ++++
 3 files changed, 8 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index eb8c45b..c1c9670 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -181,6 +181,7 @@ struct f2fs_inode_info {
 	f2fs_hash_t chash;		/* hash value of given file name */
 	unsigned int clevel;		/* maximum level of given file name */
 	nid_t i_xattr_nid;		/* node id that contains xattrs */
+	unsigned long long xattr_ver;	/* cp version of xattr modification */
 	struct extent_info ext;		/* in-memory extent cache entry */
 };
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c2deb27..49a414d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -161,6 +161,9 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		need_cp = true;
 	else if (!is_checkpointed_node(sbi, F2FS_I(inode)->i_pino))
 		need_cp = true;
+	else if (F2FS_I(inode)->xattr_ver ==
+			le64_to_cpu(F2FS_CKPT(sbi)->checkpoint_ver))
+		need_cp = true;
 
 	if (need_cp) {
 		nid_t pino;
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 3ab07ec..0f6d2a1 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -486,6 +486,10 @@ int f2fs_setxattr(struct inode *inode, int name_index, const char *name,
 		inode->i_ctime = CURRENT_TIME;
 		clear_inode_flag(fi, FI_ACL_MODE);
 	}
+
+	/* store checkpoint version for conducting checkpoint during fsync */
+	fi->xattr_ver = le64_to_cpu(F2FS_CKPT(sbi)->checkpoint_ver);
+
 	if (ipage)
 		update_inode(inode, ipage);
 	else
-- 
1.8.3.1.437.g0dbd812


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
