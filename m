From: heyunlei <heyunlei@huawei.com>
Subject: Re: [PATCH v3] f2fs: check blkaddr more accuratly before
 issue a bio
Date: Fri, 9 Mar 2018 10:08:34 +0000
Message-ID: <42B685BFA705F94C860C6DD0752F056548348E30@DGGEMA503-MBX.china.huawei.com>
References: <1520589133-30033-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1euExK-0006bx-Sq
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Mar 2018 10:08:54 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1euExI-00AJER-W6
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Mar 2018 10:08:54 +0000
In-Reply-To: <1520589133-30033-1-git-send-email-heyunlei@huawei.com>
Content-Language: zh-CN
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: heyunlei <heyunlei@huawei.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "Yuchao (T)" <yuchao0@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
Cc: "Zhangdianfang (Euler)" <zhangdianfang@huawei.com>



>-----Original Message-----
>From: heyunlei
>Sent: Friday, March 09, 2018 5:52 PM
>To: jaegeuk@kernel.org; Yuchao (T); linux-f2fs-devel@lists.sourceforge.net
>Cc: Wangbintian; Zhangdianfang (Euler); heyunlei
>Subject: [f2fs-dev][PATCH v3] f2fs: check blkaddr more accuratly before issue a bio
>

I'm sorry that resend this email, please ignore this!

Thanks.
>This patch check blkaddr more accuratly before issue a
>write or read bio.
>
>Signed-off-by: Yunlei He <heyunlei@huawei.com>
>---
> fs/f2fs/checkpoint.c |  2 ++
> fs/f2fs/data.c       |  5 +++--
> fs/f2fs/f2fs.h       |  1 +
> fs/f2fs/segment.h    | 25 +++++++++++++++++++------
> 4 files changed, 25 insertions(+), 8 deletions(-)
>
>diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>index 5b2db75..bf77946 100644
>--- a/fs/f2fs/checkpoint.c
>+++ b/fs/f2fs/checkpoint.c
>@@ -68,6 +68,7 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
> 		.old_blkaddr = index,
> 		.new_blkaddr = index,
> 		.encrypted_page = NULL,
>+		.is_meta = is_meta,
> 	};
>
> 	if (unlikely(!is_meta))
>@@ -162,6 +163,7 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
> 		.op_flags = sync ? (REQ_META | REQ_PRIO) : REQ_RAHEAD,
> 		.encrypted_page = NULL,
> 		.in_list = false,
>+		.is_meta = (type != META_POR),
> 	};
> 	struct blk_plug plug;
>
>diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>index 6c3c978..de036e8 100644
>--- a/fs/f2fs/data.c
>+++ b/fs/f2fs/data.c
>@@ -383,6 +383,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
> 	struct page *page = fio->encrypted_page ?
> 			fio->encrypted_page : fio->page;
>
>+	verify_block_addr(fio, fio->new_blkaddr);
> 	trace_f2fs_submit_page_bio(page, fio);
> 	f2fs_trace_ios(fio, 0);
>
>@@ -428,8 +429,8 @@ int f2fs_submit_page_write(struct f2fs_io_info *fio)
> 	}
>
> 	if (fio->old_blkaddr != NEW_ADDR)
>-		verify_block_addr(sbi, fio->old_blkaddr);
>-	verify_block_addr(sbi, fio->new_blkaddr);
>+		verify_block_addr(fio, fio->old_blkaddr);
>+	verify_block_addr(fio, fio->new_blkaddr);
>
> 	bio_page = fio->encrypted_page ? fio->encrypted_page : fio->page;
>
>diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>index f6dc706..842adea 100644
>--- a/fs/f2fs/f2fs.h
>+++ b/fs/f2fs/f2fs.h
>@@ -980,6 +980,7 @@ struct f2fs_io_info {
> 	bool submitted;		/* indicate IO submission */
> 	int need_lock;		/* indicate we need to lock cp_rwsem */
> 	bool in_list;		/* indicate fio is in io_list */
>+	bool is_meta;		/* indicate borrow meta inode mapping or not */
> 	enum iostat_type io_type;	/* io type */
> 	struct writeback_control *io_wbc; /* writeback control */
> };
>diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>index dbb774aa..3325d07 100644
>--- a/fs/f2fs/segment.h
>+++ b/fs/f2fs/segment.h
>@@ -53,13 +53,19 @@
> 	 ((secno) == CURSEG_I(sbi, CURSEG_COLD_NODE)->segno /		\
> 	  (sbi)->segs_per_sec))	\
>
>-#define MAIN_BLKADDR(sbi)	(SM_I(sbi)->main_blkaddr)
>-#define SEG0_BLKADDR(sbi)	(SM_I(sbi)->seg0_blkaddr)
>+#define MAIN_BLKADDR(sbi)						\
>+	(SM_I(sbi) ? SM_I(sbi)->main_blkaddr : 				\
>+		le32_to_cpu(F2FS_RAW_SUPER(sbi)->main_blkaddr))
>+#define SEG0_BLKADDR(sbi)						\
>+	(SM_I(sbi) ? SM_I(sbi)->seg0_blkaddr : 				\
>+		le32_to_cpu(F2FS_RAW_SUPER(sbi)->segment0_blkaddr))
>
> #define MAIN_SEGS(sbi)	(SM_I(sbi)->main_segments)
> #define MAIN_SECS(sbi)	((sbi)->total_sections)
>
>-#define TOTAL_SEGS(sbi)	(SM_I(sbi)->segment_count)
>+#define TOTAL_SEGS(sbi)							\
>+	(SM_I(sbi) ? SM_I(sbi)->segment_count : 				\
>+		le32_to_cpu(F2FS_RAW_SUPER(sbi)->segment_count))
> #define TOTAL_BLKS(sbi)	(TOTAL_SEGS(sbi) << (sbi)->log_blocks_per_seg)
>
> #define MAX_BLKADDR(sbi)	(SEG0_BLKADDR(sbi) + TOTAL_BLKS(sbi))
>@@ -632,10 +638,17 @@ static inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
> 	f2fs_bug_on(sbi, segno > TOTAL_SEGS(sbi) - 1);
> }
>
>-static inline void verify_block_addr(struct f2fs_sb_info *sbi, block_t blk_addr)
>+static inline void verify_block_addr(struct f2fs_io_info *fio, block_t blk_addr)
> {
>-	BUG_ON(blk_addr < SEG0_BLKADDR(sbi)
>-			|| blk_addr >= MAX_BLKADDR(sbi));
>+	struct f2fs_sb_info *sbi = fio->sbi;
>+
>+	if (PAGE_TYPE_OF_BIO(fio->type) == META &&
>+				(!is_read_io(fio->op) || fio->is_meta))
>+		BUG_ON(blk_addr < SEG0_BLKADDR(sbi) ||
>+				blk_addr >= MAIN_BLKADDR(sbi));
>+	else
>+		BUG_ON(blk_addr < MAIN_BLKADDR(sbi) ||
>+				blk_addr >= MAX_BLKADDR(sbi));
> }
>
> /*
>--
>1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
