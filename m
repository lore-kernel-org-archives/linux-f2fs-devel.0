From: Yufen Yu <yuyufen@huawei.com>
Subject: [PATCH] f2fs: implement cgroup writeback supprot
Date: Fri, 5 Jan 2018 14:28:29 +0800
Message-ID: <20180105062829.11236-1-yuyufen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Yufen Yu <yuyufen@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Cgroup writeback requires explicit support from the filesystem.
f2fs's data and node writeback IOs go through __write_data_page,
which sets fio for submiting IOs. So, we add io_wbc for fio,
associate bios with blkcg by invoking wbc_init_bio() and
account IOs issuing by wbc_account_io().
In addtion, f2fs_fill_super() is updated to set SB_I_CGROUPWB.

Meta writeback IOs is left alone by this patch and will always be
attributed to the root cgroup.

The results show that f2fs can throttle writeback nicely for
data writing and file creating.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 fs/f2fs/data.c  | 11 +++++++++--
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/node.c  |  1 +
 fs/f2fs/super.c |  1 +
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 516fa0d..402df03 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -169,6 +169,7 @@ static bool __same_bdev(struct f2fs_sb_info *sbi,
  * Low-level block read/write IO operations.
  */
 static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
+				struct writeback_control *wbc,
 				int npages, bool is_read)
 {
 	struct bio *bio;
@@ -178,6 +179,8 @@ static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
 	f2fs_target_device(sbi, blk_addr, bio);
 	bio->bi_end_io = is_read ? f2fs_read_end_io : f2fs_write_end_io;
 	bio->bi_private = is_read ? NULL : sbi;
+	if (wbc)
+		wbc_init_bio(wbc, bio);
 
 	return bio;
 }
@@ -373,7 +376,8 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 	f2fs_trace_ios(fio, 0);
 
 	/* Allocate a new bio */
-	bio = __bio_alloc(fio->sbi, fio->new_blkaddr, 1, is_read_io(fio->op));
+	bio = __bio_alloc(fio->sbi, fio->new_blkaddr, fio->io_wbc,
+				1, is_read_io(fio->op));
 
 	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
 		bio_put(bio);
@@ -435,7 +439,7 @@ int f2fs_submit_page_write(struct f2fs_io_info *fio)
 			dec_page_count(sbi, WB_DATA_TYPE(bio_page));
 			goto out_fail;
 		}
-		io->bio = __bio_alloc(sbi, fio->new_blkaddr,
+		io->bio = __bio_alloc(sbi, fio->new_blkaddr, fio->io_wbc,
 						BIO_MAX_PAGES, false);
 		io->fio = *fio;
 	}
@@ -443,6 +447,8 @@ int f2fs_submit_page_write(struct f2fs_io_info *fio)
 	if (bio_add_page(io->bio, bio_page, PAGE_SIZE, 0) < PAGE_SIZE) {
 		__submit_merged_bio(io);
 		goto alloc_new;
+	} else if (fio->io_wbc) {
+		wbc_account_io(fio->io_wbc, bio_page, PAGE_SIZE);
 	}
 
 	io->last_block_in_bio = fio->new_blkaddr;
@@ -1508,6 +1514,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 		.submitted = false,
 		.need_lock = LOCK_RETRY,
 		.io_type = io_type,
+		.io_wbc = wbc,
 	};
 
 	trace_f2fs_writepage(page, DATA);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6abf26c..4887dde 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -957,6 +957,7 @@ struct f2fs_io_info {
 	int need_lock;		/* indicate we need to lock cp_rwsem */
 	bool in_list;		/* indicate fio is in io_list */
 	enum iostat_type io_type;	/* io type */
+	struct writeback_control *io_wbc; /* writeback control */
 };
 
 #define is_read_io(rw) ((rw) == READ)
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d332275..e4f8bb0 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1336,6 +1336,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 		.encrypted_page = NULL,
 		.submitted = false,
 		.io_type = io_type,
+		.io_wbc = wbc,
 	};
 
 	trace_f2fs_writepage(page, NODE);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 708155d..deeba98 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2475,6 +2475,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
 	memcpy(&sb->s_uuid, raw_super->uuid, sizeof(raw_super->uuid));
+	sb->s_iflags |= SB_I_CGROUPWB;
 
 	/* init f2fs-specific super block info */
 	sbi->valid_super_block = valid_super_block;
-- 
2.9.5
