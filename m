From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 07/11] f2fs: enable in-place-update for fdatasync
Date: Fri, 25 Jul 2014 15:47:21 -0700
Message-ID: <1406328445-63707-7-git-send-email-jaegeuk@kernel.org>
References: <1406328445-63707-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XAoIs-0005xr-9D
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Jul 2014 22:49:30 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XAoIr-0006MZ-I5 for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Jul 2014 22:49:30 +0000
In-Reply-To: <1406328445-63707-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch enforces in-place-updates only when fdatasync is requested.
If we adopt this in-place-updates for the fdatasync, we can skip to write the
recovery information.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h    | 1 +
 fs/f2fs/file.c    | 7 +++++++
 fs/f2fs/segment.h | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ab36025..8f8685e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -998,6 +998,7 @@ enum {
 	FI_INLINE_DATA,		/* used for inline data*/
 	FI_APPEND_WRITE,	/* inode has appended data */
 	FI_UPDATE_WRITE,	/* inode has in-place-update data */
+	FI_NEED_IPU,		/* used fo ipu for fdatasync */
 };
 
 static inline void set_inode_flag(struct f2fs_inode_info *fi, int flag)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 121689a..e339856 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -127,11 +127,18 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		return 0;
 
 	trace_f2fs_sync_file_enter(inode);
+
+	/* if fdatasync is triggered, let's do in-place-update */
+	if (datasync)
+		set_inode_flag(fi, FI_NEED_IPU);
+
 	ret = filemap_write_and_wait_range(inode->i_mapping, start, end);
 	if (ret) {
 		trace_f2fs_sync_file_exit(inode, need_cp, datasync, ret);
 		return ret;
 	}
+	if (datasync)
+		clear_inode_flag(fi, FI_NEED_IPU);
 
 	/*
 	 * if there is no written data, don't waste time to write recovery info.
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index ee5c75e..55973f7 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -486,6 +486,10 @@ static inline bool need_inplace_update(struct inode *inode)
 	if (S_ISDIR(inode->i_mode))
 		return false;
 
+	/* this is only set during fdatasync */
+	if (is_inode_flag_set(F2FS_I(inode), FI_NEED_IPU))
+		return true;
+
 	switch (SM_I(sbi)->ipu_policy) {
 	case F2FS_IPU_FORCE:
 		return true;
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
