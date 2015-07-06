From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] f2fs: enhance multithread performance
Date: Mon, 06 Jul 2015 20:31:49 +0800
Message-ID: <004901d0b7e7$d2c0e650$7842b2f0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In ->writepages, we use writepages mutex lock to serialize all block
address allocation and page submitting pairs from different inodes.
This method makes our delayed dirty pages of one inode being written
continously as many as possible.

But there is one problem that we did not submit current cached bio in
protection region of writepages mutex lock, so there is a small chance
that we submit the one of other thread's as below, resulting in
splitting more bios.

thread 1			thread 2
->writepages
  lock(writepages)
  ->write_cache_pages
  unlock(writepages)
				  lock(writepages)
				  ->write_cache_pages
  ->f2fs_submit_merged_bio
				    ->writepage
				  unlock(writepages)

fs_mark-6535  [002] ....  2242.270230: f2fs_submit_write_bio: dev = (1,0), WRITE_SYNC, DATA, sector = 5766152, size = 524288
fs_mark-6536  [000] ....  2242.270361: f2fs_submit_write_bio: dev = (1,0), WRITE_SYNC, DATA, sector = 5767176, size = 4096
fs_mark-6536  [000] ....  2242.270370: f2fs_submit_write_bio: dev = (1,0), WRITE_SYNC, NODE, sector = 8138112, size = 4096
fs_mark-6535  [002] ....  2242.270776: f2fs_submit_write_bio: dev = (1,0), WRITE_SYNC, DATA, sector = 5767184, size = 516096

This may really increase time of block layer works, and may cause
larger IO lantency.

This patch moves the submitting operation into region of writepages
mutex lock to avoid bio splits when concurrently writebacking is
intensive.

my test environment: virtual machine,
intel cpu i5 2500, 8GB size memory, 4GB size ramdisk

time fs_mark  -t  16  -L  1  -s  524288  -S  1  -d  /mnt/f2fs/

before:
real	0m4.244s
user	0m0.088s
sys	0m12.336s

after:
real	0m3.822s
user	0m0.072s
sys	0m10.760s

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6cf75d3..37a2632 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1703,11 +1703,10 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 		locked = true;
 	}
 	ret = write_cache_pages(mapping, wbc, __f2fs_writepage, mapping);
+	f2fs_submit_merged_bio(sbi, DATA, WRITE);
 	if (locked)
 		mutex_unlock(&sbi->writepages);
 
-	f2fs_submit_merged_bio(sbi, DATA, WRITE);
-
 	remove_dirty_dir_inode(inode);
 
 	wbc->nr_to_write = max((long)0, wbc->nr_to_write - diff);
-- 
2.4.2
