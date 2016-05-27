From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] f2fs: do not skip writing data pages
Date: Thu, 26 May 2016 17:25:23 -0700
Message-ID: <1464308724-71070-3-git-send-email-jaegeuk@kernel.org>
References: <1464308724-71070-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464308724-71070-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

For data pages, let's try to flush as much as possible in background.

On /dev/pmem0,

1. dd if=/dev/zero of=/mnt/test/testfile bs=1M count=2048 conv=fsync
 Before : 800 MB/s
 After  : 1.1 GB/s

2. dd if=/dev/zero of=/mnt/test/testfile bs=1M count=2048
 Before : 1.3 GB/s
 After  : 2.2 GB/s

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c    | 11 +++++------
 fs/f2fs/segment.h |  4 +---
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7132b02..85ceb2b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1444,7 +1444,6 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int ret;
-	long diff;
 
 	/* deal with chardevs and other special file */
 	if (!mapping->a_ops->writepage)
@@ -1469,14 +1468,14 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 
 	trace_f2fs_writepages(mapping->host, wbc, DATA);
 
-	diff = nr_pages_to_write(sbi, DATA, wbc);
-
 	ret = f2fs_write_cache_pages(mapping, wbc, __f2fs_writepage, mapping);
-	f2fs_submit_merged_bio_cond(sbi, inode, NULL, 0, DATA, WRITE);
+	/*
+	 * if some pages were truncated, we cannot guarantee its mapping->host
+	 * to detect pending bios.
+	 */
+	f2fs_submit_merged_bio(sbi, DATA, WRITE);
 
 	remove_dirty_inode(inode);
-
-	wbc->nr_to_write = max((long)0, wbc->nr_to_write - diff);
 	return ret;
 
 skip_write:
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 5d016a1..890bb28d 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -728,9 +728,7 @@ static inline long nr_pages_to_write(struct f2fs_sb_info *sbi, int type,
 
 	nr_to_write = wbc->nr_to_write;
 
-	if (type == DATA)
-		desired = 4096;
-	else if (type == NODE)
+	if (type == NODE)
 		desired = 3 * max_hw_blocks(sbi);
 	else
 		desired = MAX_BIO_BLOCKS(sbi);
-- 
2.6.3
