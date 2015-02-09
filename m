From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: avoid data offset overflow when lseeking huge file
Date: Mon, 09 Feb 2015 11:23:58 +0800
Message-ID: <004501d04418$006f4360$014dca20$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

xfstest generic/285 complains our issue in lseeking huge file.

Here is the detail output of generic/285:
"./check -f2fs tests/generic/285
Ran: generic/285
Failures: generic/285
Failed 1 of 1 tests

10. Test a huge file for offset overflow
10.01 SEEK_HOLE expected 65536 or 8589934592, got 65536.          succ
10.02 SEEK_HOLE expected 65536 or 8589934592, got 65536.          succ
10.03 SEEK_DATA expected 0 or 0, got 0.                           succ
10.04 SEEK_DATA expected 1 or 1, got 1.                           succ
10.05 SEEK_HOLE expected 8589934592 or 8589934592, got 0.         FAIL
10.06 SEEK_DATA expected 8589869056 or 8589869056, got 8589869056. succ
10.07 SEEK_DATA expected 8589869057 or 8589869057, got 8589869057. succ
10.08 SEEK_DATA expected 8589869056 or 8589869056, got 4294901760. FAIL"

The reason of this issue is:
We will calculate current offset through left shifting page-offset with
PAGE_CACHE_SHIFT bits, but our page-offset is a type of unsigned long, its size
is 4 bytes in 32-bits machine.

So if our page-offset is bigger than (1 << 32 / pagesize - 1), result of left
shifting will overflow.

Let's fix this issue by casting type of page-offset to type of current offset:
loff_t.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5cbbc9a..7dc0ed8 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -357,7 +357,7 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 		/* find data/hole in dnode block */
 		for (; dn.ofs_in_node < end_offset;
 				dn.ofs_in_node++, pgofs++,
-				data_ofs = pgofs << PAGE_CACHE_SHIFT) {
+				data_ofs = (loff_t)pgofs << PAGE_CACHE_SHIFT) {
 			block_t blkaddr;
 			blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
 
-- 
2.2.2
