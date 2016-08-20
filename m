From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: fix to preallocate block only aligned to 4K
Date: Sat, 20 Aug 2016 15:12:01 +0800
Message-ID: <20160820071202.31355-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

In write_begin(), we skip checking dnode block for preallocating block
when whole block needs to be updated since we preallocated its block in
f2fs_preallocate_blocks, for partial updated block, we will still try
to lock its node and do preallocation in write_begin(), so in
f2fs_preallocate_blocks we should not preallocate its block.

But previously, the calculation of preallocating block number is
incorrect, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ccb401e..dee3a78 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -626,7 +626,8 @@ ssize_t f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t ret = 0;
 
 	map.m_lblk = F2FS_BLK_ALIGN(iocb->ki_pos);
-	map.m_len = F2FS_BYTES_TO_BLK(iov_iter_count(from));
+	map.m_len = F2FS_BYTES_TO_BLK(iocb->ki_pos + iov_iter_count(from)) -
+								map.m_lblk;
 	map.m_next_pgofs = NULL;
 
 	if (f2fs_encrypted_inode(inode))
-- 
2.8.2.311.gee88674
