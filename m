From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: split bio cache
Date: Wed, 10 May 2017 11:19:11 +0800
Message-ID: <6b4272a8-a57a-e81d-d8c1-6b601f569921@huawei.com>
References: <20170508123605.111446-1-yuchao0@huawei.com>
	<20170508212324.GC47455@jaegeuk.local>
	<fe1fc9ca-e49e-1160-1f79-7b75ec7d22ef@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1d8IA5-0006Sm-Ip
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 10 May 2017 03:19:37 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d8IA3-0002zS-2i
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 10 May 2017 03:19:37 +0000
In-Reply-To: <fe1fc9ca-e49e-1160-1f79-7b75ec7d22ef@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/5/9 9:49, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2017/5/9 5:23, Jaegeuk Kim wrote:
>> Hi Chao,
>>
>> I can't see a strong reason to split meta from data/node and rename the existing
>> function names. Instead, how about keeping the existing one while adding some
>> page types to deal with log types?
> 
> Hmm.. before write this patch, I have thought about this implementation which
> adds HOT_DATA/WARM_DATA/.. into page_type enum, but the final target is making
> different temperature log-header being with independent bio cache, io lock, and
> io list, eliminating interaction of different temperature IOs, also expanding
> f2fs' scalability when adding more log-headers. If we don't split meta from
> data/node, it's a little bit hard to approach this. What do you think?

Or like this?

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index ea9c317b5916..61191df47a09 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -159,6 +159,7 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 	struct f2fs_io_info fio = {
 		.sbi = sbi,
 		.type = META,
+		.btype = META,
 		.op = REQ_OP_READ,
 		.op_flags = sync ? (REQ_META | REQ_PRIO) : REQ_RAHEAD,
 		.encrypted_page = NULL,
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7c0f6bdf817d..13c351e873d6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -182,16 +182,17 @@ static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
 }

 static inline void __submit_bio(struct f2fs_sb_info *sbi,
-				struct bio *bio, enum page_type type)
+				struct bio *bio, enum page_type btype)
 {
 	if (!is_read_io(bio_op(bio))) {
 		unsigned int start;

 		if (f2fs_sb_mounted_blkzoned(sbi->sb) &&
-			current->plug && (type == DATA || type == NODE))
+			current->plug &&
+			(btype == DATA || btype == NODE || btype <= COLD_NODE))
 			blk_finish_plug(current->plug);

-		if (type != DATA && type != NODE)
+		if (btype > COLD_NODE && btype != DATA && btype != NODE)
 			goto submit_io;

 		start = bio->bi_iter.bi_size >> F2FS_BLKSIZE_BITS;
@@ -217,14 +218,14 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
 		 * In the NODE case, we lose next block address chain. So, we
 		 * need to do checkpoint in f2fs_sync_file.
 		 */
-		if (type == NODE)
+		if (btype == DATA || btype == NODE || btype <= COLD_NODE)
 			set_sbi_flag(sbi, SBI_NEED_CP);
 	}
 submit_io:
 	if (is_read_io(bio_op(bio)))
-		trace_f2fs_submit_read_bio(sbi->sb, type, bio);
+		trace_f2fs_submit_read_bio(sbi->sb, btype, bio);
 	else
-		trace_f2fs_submit_write_bio(sbi->sb, type, bio);
+		trace_f2fs_submit_write_bio(sbi->sb, btype, bio);
 	submit_bio(bio);
 }

@@ -238,11 +239,11 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
 	bio_set_op_attrs(io->bio, fio->op, fio->op_flags);

 	if (is_read_io(fio->op))
-		trace_f2fs_prepare_read_bio(io->sbi->sb, fio->type, io->bio);
+		trace_f2fs_prepare_read_bio(io->sbi->sb, fio->btype, io->bio);
 	else
-		trace_f2fs_prepare_write_bio(io->sbi->sb, fio->type, io->bio);
+		trace_f2fs_prepare_write_bio(io->sbi->sb, fio->btype, io->bio);

-	__submit_bio(io->sbi, io->bio, fio->type);
+	__submit_bio(io->sbi, io->bio, fio->btype);
 	io->bio = NULL;
 }

@@ -279,12 +280,14 @@ static bool __has_merged_page(struct f2fs_bio_info *io,
 }

 static bool has_merged_page(struct f2fs_sb_info *sbi, struct inode *inode,
-				nid_t ino, pgoff_t idx, enum page_type type)
+			nid_t ino, pgoff_t idx, enum page_type type, int rw)
 {
 	enum page_type btype = PAGE_TYPE_OF_BIO(type);
-	struct f2fs_bio_info *io = &sbi->write_io[btype];
+	struct f2fs_bio_info *io;
 	bool ret;

+	io = is_read_io(rw) ? &sbi->read_io : &sbi->write_io[btype];
+
 	down_read(&io->io_rwsem);
 	ret = __has_merged_page(io, inode, ino, idx);
 	up_read(&io->io_rwsem);
@@ -318,18 +321,34 @@ static void __f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
 	up_write(&io->io_rwsem);
 }

-void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi, enum page_type type,
-									int rw)
-{
-	__f2fs_submit_merged_bio(sbi, NULL, 0, 0, type, rw);
-}
-
 void f2fs_submit_merged_bio_cond(struct f2fs_sb_info *sbi,
 				struct inode *inode, nid_t ino, pgoff_t idx,
 				enum page_type type, int rw)
 {
-	if (has_merged_page(sbi, inode, ino, idx, type))
-		__f2fs_submit_merged_bio(sbi, inode, ino, idx, type, rw);
+	int i;
+
+	if (type == DATA) {
+		for (i = HOT_DATA; i <= COLD_DATA; i++) {
+			if (has_merged_page(sbi, inode, ino, idx, i, rw))
+				__f2fs_submit_merged_bio(sbi, inode, ino, idx,
+									i, rw);
+		}
+	} else if (type == NODE) {
+		for (i = HOT_NODE; i <= COLD_NODE; i++) {
+			if (has_merged_page(sbi, inode, ino, idx, i, rw))
+				__f2fs_submit_merged_bio(sbi, inode, ino, idx,
+									i, rw);
+		}
+	} else {
+		if (has_merged_page(sbi, inode, ino, idx, type, rw))
+			__f2fs_submit_merged_bio(sbi, inode, ino, idx, type, rw);
+	}
+}
+
+void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi, enum page_type type,
+									int rw)
+{
+	f2fs_submit_merged_bio_cond(sbi, NULL, 0, 0, type, rw);
 }

 void f2fs_flush_merged_bios(struct f2fs_sb_info *sbi)
@@ -371,7 +390,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 int f2fs_submit_page_mbio(struct f2fs_io_info *fio)
 {
 	struct f2fs_sb_info *sbi = fio->sbi;
-	enum page_type btype = PAGE_TYPE_OF_BIO(fio->type);
+	enum page_type btype = PAGE_TYPE_OF_BIO(fio->btype);
 	struct f2fs_bio_info *io;
 	bool is_read = is_read_io(fio->op);
 	struct page *bio_page;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e26999a74522..177bccfad9ff 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -779,10 +779,16 @@ enum count_type {
  */
 #define PAGE_TYPE_OF_BIO(type)	((type) > META ? META : (type))
 enum page_type {
-	DATA,
-	NODE,
+	HOT_DATA,	/* CURSEG_HOT_DATA */
+	WARM_DATA,	/* CURSEG_WARM_DATA */
+	COLD_DATA,	/* CURSEG_COLD_DATA */
+	HOT_NODE,	/* CURSEG_HOT_NODE */
+	WARM_NODE,	/* CURSEG_WARM_NODE */
+	COLD_NODE,	/* CURSEG_COLD_NODE */
 	META,
 	NR_PAGE_TYPE,
+	DATA,
+	NODE,
 	META_FLUSH,
 	INMEM,		/* the below types are used by tracepoints only. */
 	INMEM_DROP,
@@ -795,6 +801,7 @@ enum page_type {
 struct f2fs_io_info {
 	struct f2fs_sb_info *sbi;	/* f2fs_sb_info pointer */
 	enum page_type type;	/* contains DATA/NODE/META/META_FLUSH */
+	int btype;		/* segment type and meta type */
 	int op;			/* contains REQ_OP_ */
 	int op_flags;		/* req_flag_bits */
 	block_t new_blkaddr;	/* new block address to be written */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 026522107ca3..94a4a7ab141a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -586,6 +586,7 @@ static void move_encrypted_block(struct inode *inode, block_t bidx,
 	struct f2fs_io_info fio = {
 		.sbi = F2FS_I_SB(inode),
 		.type = DATA,
+		.btype = CURSEG_COLD_DATA,
 		.op = REQ_OP_READ,
 		.op_flags = 0,
 		.encrypted_page = NULL,
@@ -632,7 +633,7 @@ static void move_encrypted_block(struct inode *inode, block_t bidx,
 	fio.new_blkaddr = fio.old_blkaddr = dn.data_blkaddr;

 	allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
-							&sum, CURSEG_COLD_DATA);
+							&sum, fio.btype);

 	fio.encrypted_page = pagecache_get_page(META_MAPPING(fio.sbi), newaddr,
 					FGP_LOCK | FGP_CREAT, GFP_NOFS);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b084b3a8f2c7..7167c502c09a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2141,14 +2141,15 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,

 static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 {
-	int type = __get_segment_type(fio->page, fio->type);
 	int err;

+	fio->btype = __get_segment_type(fio->page, fio->type);
+
 	if (fio->type == NODE || fio->type == DATA)
 		mutex_lock(&fio->sbi->wio_mutex[fio->type]);
 reallocate:
 	allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
-					&fio->new_blkaddr, sum, type);
+					&fio->new_blkaddr, sum, fio->btype);

 	/* writeout dirty page into bdev */
 	err = f2fs_submit_page_mbio(fio);
@@ -2166,6 +2167,7 @@ void write_meta_page(struct f2fs_sb_info *sbi, struct page *page)
 	struct f2fs_io_info fio = {
 		.sbi = sbi,
 		.type = META,
+		.btype = META,
 		.op = REQ_OP_WRITE,
 		.op_flags = REQ_SYNC | REQ_META | REQ_PRIO,
 		.old_blkaddr = page->index,
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 15da88c5c3a4..d9886c49b05e 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -9,8 +9,14 @@
 #define show_dev(dev)		MAJOR(dev), MINOR(dev)
 #define show_dev_ino(entry)	show_dev(entry->dev), (unsigned long)entry->ino

-TRACE_DEFINE_ENUM(NODE);
+TRACE_DEFINE_ENUM(HOT_DATA);
+TRACE_DEFINE_ENUM(WARM_DATA);
+TRACE_DEFINE_ENUM(COLD_DATA);
+TRACE_DEFINE_ENUM(HOT_NODE);
+TRACE_DEFINE_ENUM(WARM_NODE);
+TRACE_DEFINE_ENUM(COLD_NODE);
 TRACE_DEFINE_ENUM(DATA);
+TRACE_DEFINE_ENUM(NODE);
 TRACE_DEFINE_ENUM(META);
 TRACE_DEFINE_ENUM(META_FLUSH);
 TRACE_DEFINE_ENUM(INMEM);
@@ -48,9 +54,15 @@ TRACE_DEFINE_ENUM(CP_TRIMMED);

 #define show_block_type(type)						\
 	__print_symbolic(type,						\
-		{ NODE,		"NODE" },				\
-		{ DATA,		"DATA" },				\
+		{ HOT_DATA,	"HOT_DATA" },				\
+		{ WARM_DATA,	"WARM_DATA" },				\
+		{ COLD_DATA,	"COLD_DATA" },				\
+		{ HOT_NODE,	"HOT_NODE" },				\
+		{ WARM_NODE,	"WARM_NODE" },				\
+		{ COLD_NODE,	"COLD_NODE" },				\
 		{ META,		"META" },				\
+		{ DATA,		"DATA" },				\
+		{ NODE,		"NODE" },				\
 		{ META_FLUSH,	"META_FLUSH" },				\
 		{ INMEM,	"INMEM" },				\
 		{ INMEM_DROP,	"INMEM_DROP" },				\
@@ -757,7 +769,7 @@ DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
 		__field(block_t, new_blkaddr)
 		__field(int, op)
 		__field(int, op_flags)
-		__field(int, type)
+		__field(int, btype)
 	),

 	TP_fast_assign(
@@ -768,7 +780,7 @@ DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
 		__entry->new_blkaddr	= fio->new_blkaddr;
 		__entry->op		= fio->op;
 		__entry->op_flags	= fio->op_flags;
-		__entry->type		= fio->type;
+		__entry->btype		= fio->btype;
 	),

 	TP_printk("dev = (%d,%d), ino = %lu, page_index = 0x%lx, "
@@ -778,7 +790,7 @@ DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
 		(unsigned long long)__entry->old_blkaddr,
 		(unsigned long long)__entry->new_blkaddr,
 		show_bio_type(__entry->op, __entry->op_flags),
-		show_block_type(__entry->type))
+		show_block_type(__entry->btype))
 );

 DEFINE_EVENT_CONDITION(f2fs__submit_page_bio, f2fs_submit_page_bio,
@@ -810,7 +822,7 @@ DECLARE_EVENT_CLASS(f2fs__bio,
 		__field(dev_t,	target)
 		__field(int,	op)
 		__field(int,	op_flags)
-		__field(int,	type)
+		__field(int,	btype)
 		__field(sector_t,	sector)
 		__field(unsigned int,	size)
 	),
@@ -820,7 +832,7 @@ DECLARE_EVENT_CLASS(f2fs__bio,
 		__entry->target		= bio->bi_bdev->bd_dev;
 		__entry->op		= bio_op(bio);
 		__entry->op_flags	= bio->bi_opf;
-		__entry->type		= type;
+		__entry->btype		= btype;
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->size		= bio->bi_iter.bi_size;
 	),
@@ -829,7 +841,7 @@ DECLARE_EVENT_CLASS(f2fs__bio,
 		show_dev(__entry->target),
 		show_dev(__entry->dev),
 		show_bio_type(__entry->op, __entry->op_flags),
-		show_block_type(__entry->type),
+		show_block_type(__entry->btype),
 		(unsigned long long)__entry->sector,
 		__entry->size)
 );


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
