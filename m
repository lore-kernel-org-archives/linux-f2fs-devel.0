From: Wei Fang <fangwei1@huawei.com>
Subject: [PATCH] f2fs: fix a dead loop in f2fs_fiemap()
Date: Sun, 22 Jan 2017 12:21:02 +0800
Message-ID: <1485058862-19199-1-git-send-email-fangwei1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fangwei1@huawei.com>) id 1cV9em-0008WD-An
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 22 Jan 2017 04:21:32 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cV9ef-00013O-HM
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 22 Jan 2017 04:21:32 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

A dead loop can be triggered in f2fs_fiemap() using the test case
as below:

	...
	fd = open();
	fallocate(fd, 0, 0, 4294967296);
	ioctl(fd, FS_IOC_FIEMAP, fiemap_buf);
	...

It's caused by an overflow in __get_data_block():
	...
	bh->b_size = map.m_len << inode->i_blkbits;
	...
map.m_len is an unsigned int, and bh->b_size is a size_t which is 64 bits
on 64 bits archtecture, type conversion from an unsigned int to a size_t
will result in an overflow.

In the above-mentioned case, bh->b_size will be zero, and f2fs_fiemap()
will call get_data_block() at block 0 again an again.

Fix this by adding a force conversion before left shift.

Signed-off-by: Wei Fang <fangwei1@huawei.com>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 848d110..06cf0c5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -961,7 +961,7 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 	if (!err) {
 		map_bh(bh, inode->i_sb, map.m_pblk);
 		bh->b_state = (bh->b_state & ~F2FS_MAP_FLAGS) | map.m_flags;
-		bh->b_size = map.m_len << inode->i_blkbits;
+		bh->b_size = (u64)map.m_len << inode->i_blkbits;
 	}
 	return err;
 }
-- 
2.4.11


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
