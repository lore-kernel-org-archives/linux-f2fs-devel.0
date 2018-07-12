From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev v2] [PATCH 2/4] f2fs: allow wrong
 configure dio to buffered write
Date: Thu, 12 Jul 2018 10:59:02 -0700
Message-ID: <20180712175611.GA37244@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180706210903.77887-1-jaegeuk@kernel.org>
 <20180706210903.77887-2-jaegeuk@kernel.org>
 <af7e2fa5-b9e9-3090-7659-bd76585fd3aa@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fdft8-0004Rp-Po
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Jul 2018 18:00:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fdft7-007IwV-GX
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Jul 2018 18:00:22 +0000
Content-Disposition: inline
In-Reply-To: <af7e2fa5-b9e9-3090-7659-bd76585fd3aa@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This fixes to support dio having unaligned buffers as buffered writes.

xfs_io -f -d -c "pwrite 0 512" $testfile
 -> okay

xfs_io -f -d -c "pwrite 1 512" $testfile
 -> EINVAL

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
v2 from v1:
 - return error depending on sector size

 fs/f2fs/data.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8f931d699287..5e53d210e222 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2371,14 +2371,20 @@ static int f2fs_write_end(struct file *file,
 static int check_direct_IO(struct inode *inode, struct iov_iter *iter,
 			   loff_t offset)
 {
-	unsigned blocksize_mask = inode->i_sb->s_blocksize - 1;
-
-	if (offset & blocksize_mask)
-		return -EINVAL;
-
-	if (iov_iter_alignment(iter) & blocksize_mask)
-		return -EINVAL;
-
+	unsigned i_blkbits = READ_ONCE(inode->i_blkbits);
+	unsigned blkbits = i_blkbits;
+	unsigned blocksize_mask = (1 << blkbits) - 1;
+	unsigned long align = offset | iov_iter_alignment(iter);
+	struct block_device *bdev = inode->i_sb->s_bdev;
+
+	if (align & blocksize_mask) {
+		if (bdev)
+			blkbits = blksize_bits(bdev_logical_block_size(bdev));
+		blocksize_mask = (1 << blkbits) - 1;
+		if (align & blocksize_mask)
+			return -EINVAL;
+		return 1;
+	}
 	return 0;
 }
 
@@ -2396,7 +2402,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 	err = check_direct_IO(inode, iter, offset);
 	if (err)
-		return err;
+		return err < 0 ? err : 0;
 
 	if (f2fs_force_buffered_io(inode, rw))
 		return 0;
-- 
2.17.0.441.gb46fe60e1d-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
