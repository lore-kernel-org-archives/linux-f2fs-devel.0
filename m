From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH] f2fs: read isize while holding i_mutex in fiemap
Date: Mon, 04 Jan 2016 15:56:50 +0800
Message-ID: <002f01d146c5$8d872140$a89563c0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1aG01M-0008Cs-M7
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Jan 2016 07:57:40 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aG01K-0005Jz-RA
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Jan 2016 07:57:40 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O0F01ZVH4RUFQ70@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Jan 2016 16:57:30 +0900 (KST)
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

make sure the isize we read doesn't change during the process.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/data.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 11b2111..5c38f44 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -792,7 +792,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 {
 	struct buffer_head map_bh;
 	sector_t start_blk, last_blk;
-	loff_t isize = i_size_read(inode);
+	loff_t isize;
 	u64 logical = 0, phys = 0, size = 0;
 	u32 flags = 0;
 	int ret = 0;
@@ -808,6 +808,8 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	}
 
 	mutex_lock(&inode->i_mutex);
+
+	isize = i_size_read(inode);
 	if (start >= isize)
 		goto out;
 
-- 
1.7.9.5


------------------------------------------------------------------------------
