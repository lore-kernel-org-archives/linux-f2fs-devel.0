From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 03/12] f2fs: convert inline_data for various
	fallocate
Date: Mon, 29 Jun 2015 11:39:27 -0700
Message-ID: <1435603176-63219-3-git-send-email-jaegeuk@kernel.org>
References: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Z9dyZ-0000gB-CV
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 18:40:15 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z9dyT-0005Hg-Mv for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 18:40:15 +0000
In-Reply-To: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
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

For newly added fallocate types, it should convert inline_data before handling
block swapping.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ada2a3d..1b67215 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -885,6 +885,14 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	if (offset & (F2FS_BLKSIZE - 1) || len & (F2FS_BLKSIZE - 1))
 		return -EINVAL;
 
+	f2fs_balance_fs(F2FS_I_SB(inode));
+
+	if (f2fs_has_inline_data(inode)) {
+		ret = f2fs_convert_inline_inode(inode);
+		if (ret)
+			return ret;
+	}
+
 	pg_start = offset >> PAGE_CACHE_SHIFT;
 	pg_end = (offset + len) >> PAGE_CACHE_SHIFT;
 
@@ -1033,6 +1041,12 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 
 	f2fs_balance_fs(sbi);
 
+	if (f2fs_has_inline_data(inode)) {
+		ret = f2fs_convert_inline_inode(inode);
+		if (ret)
+			return ret;
+	}
+
 	ret = truncate_blocks(inode, i_size_read(inode), true);
 	if (ret)
 		return ret;
-- 
2.1.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
