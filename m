From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2] f2fs: limit b_size of mapped bh in f2fs_map_bh
Date: Tue, 24 Mar 2015 13:08:05 +0800
Message-ID: <003401d065f0$9cdcb210$d6961630$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1YaH5H-0004o4-Ut
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Mar 2015 05:08:59 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1YaH5F-00085U-V5
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Mar 2015 05:08:59 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NLP00957AAQW680@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Mar 2015 14:08:50 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Map bh over max size which caller defined is not needed, limit it in
f2fs_map_bh.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
v2 change log:
 - use min() for cleanup code suggested by Jaegeuk Kim.

 fs/f2fs/data.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f0a18a0..279c9c6e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -255,15 +255,13 @@ static void f2fs_map_bh(struct super_block *sb, pgoff_t pgofs,
 			struct extent_info *ei, struct buffer_head *bh_result)
 {
 	unsigned int blkbits = sb->s_blocksize_bits;
-	size_t count;
+	size_t max_size = bh_result->b_size;
+	size_t mapped_size;
 
 	clear_buffer_new(bh_result);
 	map_bh(bh_result, sb, ei->blk + pgofs - ei->fofs);
-	count = ei->fofs + ei->len - pgofs;
-	if (count < (UINT_MAX >> blkbits))
-		bh_result->b_size = (count << blkbits);
-	else
-		bh_result->b_size = UINT_MAX;
+	mapped_size = (ei->fofs + ei->len - pgofs) << blkbits;
+	bh_result->b_size = min(max_size, mapped_size);
 }
 
 static bool lookup_extent_info(struct inode *inode, pgoff_t pgofs,
-- 
2.3.3



------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
