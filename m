From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 1/2] f2fs: fix wrong __is_meta_io() macro
Date: Mon, 15 Apr 2019 15:26:31 +0800
Message-ID: <20190415072632.2158-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch changes codes as below:
- don't use is_read_io() as a condition to judge the meta IO.
- use .is_por to replace .is_meta to indicate IO is from recovery explicitly.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2: rebase the code to last dev branch.
 fs/f2fs/checkpoint.c | 4 ++--
 fs/f2fs/data.c       | 3 ++-
 fs/f2fs/f2fs.h       | 5 ++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 935ebdb9cf47..f42b0015724b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -66,7 +66,7 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
 		.old_blkaddr = index,
 		.new_blkaddr = index,
 		.encrypted_page = NULL,
-		.is_meta = is_meta,
+		.is_por = !is_meta,
 	};
 	int err;
 
@@ -189,7 +189,7 @@ int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 		.op_flags = sync ? (REQ_META | REQ_PRIO) : REQ_RAHEAD,
 		.encrypted_page = NULL,
 		.in_list = false,
-		.is_meta = (type != META_POR),
+		.is_por = (type == META_POR),
 	};
 	struct blk_plug plug;
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9d3c11e09a03..eabd34a79451 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -456,7 +456,8 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 			fio->encrypted_page : fio->page;
 
 	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
-			__is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))
+			fio->is_por ? META_POR :
+			(__is_meta_io(fio) ? META_GENERIC : DATA_GENERIC)))
 		return -EFAULT;
 
 	trace_f2fs_submit_page_bio(page, fio);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d5478f94cd25..003a07bd56e3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1041,7 +1041,7 @@ struct f2fs_io_info {
 	bool submitted;		/* indicate IO submission */
 	int need_lock;		/* indicate we need to lock cp_rwsem */
 	bool in_list;		/* indicate fio is in io_list */
-	bool is_meta;		/* indicate borrow meta inode mapping or not */
+	bool is_por;		/* indicate IO is from recovery or not */
 	bool retry;		/* need to reallocate block address */
 	enum iostat_type io_type;	/* io type */
 	struct writeback_control *io_wbc; /* writeback control */
@@ -2814,8 +2814,7 @@ static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi,
 
 #define __is_large_section(sbi)		((sbi)->segs_per_sec > 1)
 
-#define __is_meta_io(fio) (PAGE_TYPE_OF_BIO((fio)->type) == META &&	\
-				(!is_read_io((fio)->op) || (fio)->is_meta))
+#define __is_meta_io(fio) (PAGE_TYPE_OF_BIO((fio)->type) == META)
 
 bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 					block_t blkaddr, int type);
-- 
2.18.0.rc1
