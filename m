From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH 1/3] f2fs: avoid calling i_size_read when it's
 unnecessary
Date: Wed, 30 Dec 2015 16:49:56 +0800
Message-ID: <000c01d142df$24fdd450$6ef97cf0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1aECSy-0000kK-5K
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 08:50:44 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aECSv-0002f0-V3
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 08:50:44 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O0501G41XW4TV90@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 17:50:33 +0900 (KST)
Content-language: en-us
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

i_size_read does more than reading a value, it's best that we use it
only when we need it.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/data.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d67c599..a9a4d89 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -780,7 +780,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 {
 	struct buffer_head map_bh;
 	sector_t start_blk, last_blk;
-	loff_t isize = i_size_read(inode);
+	loff_t isize;
 	u64 logical = 0, phys = 0, size = 0;
 	u32 flags = 0;
 	int ret = 0;
@@ -795,6 +795,8 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			return ret;
 	}
 
+	isize = i_size_read(inode);
+
 	mutex_lock(&inode->i_mutex);
 	if (start >= isize)
 		goto out;
-- 
1.7.9.5



------------------------------------------------------------------------------
