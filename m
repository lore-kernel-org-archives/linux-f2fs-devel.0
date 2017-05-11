From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: split bio cache
Date: Thu, 11 May 2017 10:20:03 +0800
Message-ID: <b6e952dc-f1b8-7611-2d62-2fb7c285b327@huawei.com>
References: <20170508123605.111446-1-yuchao0@huawei.com>
	<20170508212324.GC47455@jaegeuk.local>
	<fe1fc9ca-e49e-1160-1f79-7b75ec7d22ef@huawei.com>
	<20170510235005.GA3428@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1d8djI-0002eK-UJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 11 May 2017 02:21:24 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d8djE-0004xD-TJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 11 May 2017 02:21:24 +0000
In-Reply-To: <20170510235005.GA3428@jaegeuk.local>
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

On 2017/5/11 7:50, Jaegeuk Kim wrote:
> On 05/09, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2017/5/9 5:23, Jaegeuk Kim wrote:
>>> Hi Chao,
>>>
>>> I can't see a strong reason to split meta from data/node and rename the existing
>>> function names. Instead, how about keeping the existing one while adding some
>>> page types to deal with log types?
>>
>> Hmm.. before write this patch, I have thought about this implementation which
>> adds HOT_DATA/WARM_DATA/.. into page_type enum, but the final target is making
>> different temperature log-header being with independent bio cache, io lock, and
>> io list, eliminating interaction of different temperature IOs, also expanding
>> f2fs' scalability when adding more log-headers. If we don't split meta from
>> data/node, it's a little bit hard to approach this. What do you think?
> 
> I submitted clean-up patches. How about this on top of them?

After splitting, bio caches is connected to log-header, so why not moving bio
cache into log-header (SM_I(sbi)->curseg_array)? after the merging:
- we could avoid redundant enum. e.g. temp_type, page_type::{DATA/NODE}, since
we have seg_type enum instead.
- once we add special log-header like journal log or random IO log making
DATA/NODE and HOT/WARM/COLD non-orthogonalization, we just need to change few
codes to adjust it.

How do you think?

Thanks,

> 
> ---
>  fs/f2fs/data.c              | 51 +++++++++++++++++++++++++++++++++------------
>  fs/f2fs/f2fs.h              | 10 ++++++++-
>  fs/f2fs/gc.c                |  2 ++
>  fs/f2fs/segment.c           | 24 +++++++++++++++------
>  fs/f2fs/segment.h           |  4 ++++
>  fs/f2fs/super.c             | 21 ++++++++++++++++---
>  include/trace/events/f2fs.h | 14 ++++++++++++-
>  7 files changed, 102 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 06bb2042385e..49b7e3918484 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -282,21 +282,30 @@ static bool has_merged_page(struct f2fs_sb_info *sbi, struct inode *inode,
>  				nid_t ino, pgoff_t idx, enum page_type type)
>  {
>  	enum page_type btype = PAGE_TYPE_OF_BIO(type);
> -	struct f2fs_bio_info *io = &sbi->write_io[btype];
> -	bool ret;
> +	enum temp_type temp;
> +	struct f2fs_bio_info *io;
> +	bool ret = false;
>  
> -	down_read(&io->io_rwsem);
> -	ret = __has_merged_page(io, inode, ino, idx);
> -	up_read(&io->io_rwsem);
> +	for (temp = HOT; temp < NR_TEMP_TYPE; temp++) {
> +		io = sbi->write_io[btype] + temp;
> +
> +		down_read(&io->io_rwsem);
> +		ret = __has_merged_page(io, inode, ino, idx);
> +		up_read(&io->io_rwsem);
> +
> +		/* TODO: use HOT temp only for meta pages now. */
> +		if (ret || btype == META)
> +			break;
> +	}
>  	return ret;
>  }
>  
>  static void __f2fs_submit_merged_write(struct f2fs_sb_info *sbi,
>  				struct inode *inode, nid_t ino, pgoff_t idx,
> -				enum page_type type)
> +				enum page_type type, enum temp_type temp)
>  {
>  	enum page_type btype = PAGE_TYPE_OF_BIO(type);
> -	struct f2fs_bio_info *io = &sbi->write_io[btype];
> +	struct f2fs_bio_info *io = sbi->write_io[btype] + temp;
>  
>  	down_write(&io->io_rwsem);
>  
> @@ -316,17 +325,34 @@ static void __f2fs_submit_merged_write(struct f2fs_sb_info *sbi,
>  	up_write(&io->io_rwsem);
>  }
>  
> +static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
> +				struct inode *inode, nid_t ino, pgoff_t idx,
> +				enum page_type type, bool force)
> +{
> +	enum temp_type temp;
> +
> +	if (!force && !has_merged_page(sbi, inode, ino, idx, type))
> +		return;
> +
> +	for (temp = HOT; temp < NR_TEMP_TYPE; temp++) {
> +		__f2fs_submit_merged_write(sbi, inode, ino, idx, type, temp);
> +
> +		/* TODO: use HOT temp only for meta pages now. */
> +		if (type >= META)
> +			break;
> +	}
> +}
> +
>  void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type)
>  {
> -	__f2fs_submit_merged_write(sbi, NULL, 0, 0, type);
> +	__submit_merged_write_cond(sbi, NULL, 0, 0, type, true);
>  }
>  
>  void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
>  				struct inode *inode, nid_t ino, pgoff_t idx,
>  				enum page_type type)
>  {
> -	if (has_merged_page(sbi, inode, ino, idx, type))
> -		__f2fs_submit_merged_write(sbi, inode, ino, idx, type);
> +	__submit_merged_write_cond(sbi, inode, ino, idx, type, false);
>  }
>  
>  void f2fs_flush_merged_writes(struct f2fs_sb_info *sbi)
> @@ -369,7 +395,7 @@ int f2fs_submit_page_write(struct f2fs_io_info *fio)
>  {
>  	struct f2fs_sb_info *sbi = fio->sbi;
>  	enum page_type btype = PAGE_TYPE_OF_BIO(fio->type);
> -	struct f2fs_bio_info *io = &sbi->write_io[btype];
> +	struct f2fs_bio_info *io = sbi->write_io[btype] + fio->temp;
>  	struct page *bio_page;
>  	int err = 0;
>  
> @@ -405,8 +431,7 @@ int f2fs_submit_page_write(struct f2fs_io_info *fio)
>  		io->fio = *fio;
>  	}
>  
> -	if (bio_add_page(io->bio, bio_page, PAGE_SIZE, 0) <
> -							PAGE_SIZE) {
> +	if (bio_add_page(io->bio, bio_page, PAGE_SIZE, 0) < PAGE_SIZE) {
>  		__submit_merged_bio(io);
>  		goto alloc_new;
>  	}
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index bf837458cb18..90e97bc11972 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -792,9 +792,17 @@ enum page_type {
>  	OPU,
>  };
>  
> +enum temp_type {
> +	HOT = 0,	/* must be zero for meta bio */
> +	WARM,
> +	COLD,
> +	NR_TEMP_TYPE,
> +};
> +
>  struct f2fs_io_info {
>  	struct f2fs_sb_info *sbi;	/* f2fs_sb_info pointer */
>  	enum page_type type;	/* contains DATA/NODE/META/META_FLUSH */
> +	enum temp_type temp;	/* contains HOT/WARM/COLD */
>  	int op;			/* contains REQ_OP_ */
>  	int op_flags;		/* req_flag_bits */
>  	block_t new_blkaddr;	/* new block address to be written */
> @@ -880,7 +888,7 @@ struct f2fs_sb_info {
>  
>  	/* for bio operations */
>  	struct f2fs_bio_info read_io;			/* for read bios */
> -	struct f2fs_bio_info write_io[NR_PAGE_TYPE];	/* for write bios */
> +	struct f2fs_bio_info *write_io[NR_PAGE_TYPE];	/* for write bios */
>  	struct mutex wio_mutex[NODE + 1];	/* bio ordering for NODE/DATA */
>  	int write_io_size_bits;			/* Write IO size bits */
>  	mempool_t *write_io_dummy;		/* Dummy pages */
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 67b87155bc48..e2b13558a915 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -586,6 +586,7 @@ static void move_encrypted_block(struct inode *inode, block_t bidx,
>  	struct f2fs_io_info fio = {
>  		.sbi = F2FS_I_SB(inode),
>  		.type = DATA,
> +		.temp = COLD,
>  		.op = REQ_OP_READ,
>  		.op_flags = 0,
>  		.encrypted_page = NULL,
> @@ -712,6 +713,7 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
>  		struct f2fs_io_info fio = {
>  			.sbi = F2FS_I_SB(inode),
>  			.type = DATA,
> +			.temp = COLD,
>  			.op = REQ_OP_WRITE,
>  			.op_flags = REQ_SYNC,
>  			.old_blkaddr = NULL_ADDR,
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index c9f3a2faee21..da4fd2c29e86 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2084,17 +2084,29 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
>  
>  static int __get_segment_type(struct f2fs_io_info *fio)
>  {
> +	int type;
> +
>  	switch (fio->sbi->active_logs) {
>  	case 2:
> -		return __get_segment_type_2(fio);
> +		type = __get_segment_type_2(fio);
> +		break;
>  	case 4:
> -		return __get_segment_type_4(fio);
> +		type = __get_segment_type_4(fio);
> +		break;
> +	case 6:
> +		type = __get_segment_type_6(fio);
> +		break;
> +	default:
> +		f2fs_bug_on(fio->sbi, true);
>  	}
>  
> -	/* NR_CURSEG_TYPE(6) logs by default */
> -	f2fs_bug_on(fio->sbi, fio->sbi->active_logs != NR_CURSEG_TYPE);
> -
> -	return __get_segment_type_6(fio);
> +	if (IS_HOT(type))
> +		fio->temp = HOT;
> +	else if (IS_WARM(type))
> +		fio->temp = WARM;
> +	else
> +		fio->temp = COLD;
> +	return type;
>  }
>  
>  void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 10bf05d4cff4..e9ba1f1d9723 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -27,6 +27,10 @@
>  #define IS_DATASEG(t)	((t) <= CURSEG_COLD_DATA)
>  #define IS_NODESEG(t)	((t) >= CURSEG_HOT_NODE)
>  
> +#define IS_HOT(t)	((t) == CURSEG_HOT_NODE || (t) == CURSEG_HOT_DATA)
> +#define IS_WARM(t)	((t) == CURSEG_WARM_NODE || (t) == CURSEG_WARM_DATA)
> +#define IS_COLD(t)	((t) == CURSEG_COLD_NODE || (t) == CURSEG_COLD_DATA)
> +
>  #define IS_CURSEG(sbi, seg)						\
>  	(((seg) == CURSEG_I(sbi, CURSEG_HOT_DATA)->segno) ||	\
>  	 ((seg) == CURSEG_I(sbi, CURSEG_WARM_DATA)->segno) ||	\
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 104a571a41c0..91599c9c3ef6 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -768,6 +768,7 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
>  static void f2fs_put_super(struct super_block *sb)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> +	int i;
>  
>  	if (sbi->s_proc) {
>  		remove_proc_entry("segment_info", sbi->s_proc);
> @@ -838,6 +839,8 @@ static void f2fs_put_super(struct super_block *sb)
>  	destroy_device_list(sbi);
>  	mempool_destroy(sbi->write_io_dummy);
>  	destroy_percpu_info(sbi);
> +	for (i = 0; i < NR_PAGE_TYPE; i++)
> +		kfree(sbi->write_io[i]);
>  	kfree(sbi);
>  }
>  
> @@ -1954,9 +1957,19 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  	sbi->read_io.sbi = sbi;
>  	sbi->read_io.bio = NULL;
>  	for (i = 0; i < NR_PAGE_TYPE; i++) {
> -		init_rwsem(&sbi->write_io[i].io_rwsem);
> -		sbi->write_io[i].sbi = sbi;
> -		sbi->write_io[i].bio = NULL;
> +		int n = (i == META) ? 1: NR_TEMP_TYPE;
> +		int j;
> +
> +		sbi->write_io[i] = kmalloc(n * sizeof(struct f2fs_bio_info),
> +								GFP_KERNEL);
> +		if (!sbi->write_io[i])
> +			goto free_options;
> +
> +		for (j = HOT; j < n; j++) {
> +			init_rwsem(&sbi->write_io[i][j].io_rwsem);
> +			sbi->write_io[i][j].sbi = sbi;
> +			sbi->write_io[i][j].bio = NULL;
> +		}
>  	}
>  
>  	init_rwsem(&sbi->cp_rwsem);
> @@ -2202,6 +2215,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  free_io_dummy:
>  	mempool_destroy(sbi->write_io_dummy);
>  free_options:
> +	for (i = 0; i < NR_PAGE_TYPE; i++)
> +		kfree(sbi->write_io[i]);
>  	destroy_percpu_info(sbi);
>  	kfree(options);
>  free_sb_buf:
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index 5805d92893a8..6f77a2755abb 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -19,6 +19,9 @@ TRACE_DEFINE_ENUM(INMEM_INVALIDATE);
>  TRACE_DEFINE_ENUM(INMEM_REVOKE);
>  TRACE_DEFINE_ENUM(IPU);
>  TRACE_DEFINE_ENUM(OPU);
> +TRACE_DEFINE_ENUM(HOT);
> +TRACE_DEFINE_ENUM(WARM);
> +TRACE_DEFINE_ENUM(COLD);
>  TRACE_DEFINE_ENUM(CURSEG_HOT_DATA);
>  TRACE_DEFINE_ENUM(CURSEG_WARM_DATA);
>  TRACE_DEFINE_ENUM(CURSEG_COLD_DATA);
> @@ -59,6 +62,12 @@ TRACE_DEFINE_ENUM(CP_TRIMMED);
>  		{ IPU,		"IN-PLACE" },				\
>  		{ OPU,		"OUT-OF-PLACE" })
>  
> +#define show_block_temp(temp)						\
> +	__print_symbolic(temp,						\
> +		{ HOT,		"HOT" },				\
> +		{ WARM,		"WARM" },				\
> +		{ COLD,		"COLD" })
> +
>  #define F2FS_OP_FLAGS (REQ_RAHEAD | REQ_SYNC | REQ_META | REQ_PRIO |	\
>  			REQ_PREFLUSH | REQ_FUA)
>  #define F2FS_BIO_FLAG_MASK(t)	(t & F2FS_OP_FLAGS)
> @@ -757,6 +766,7 @@ DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
>  		__field(block_t, new_blkaddr)
>  		__field(int, op)
>  		__field(int, op_flags)
> +		__field(int, temp)
>  		__field(int, type)
>  	),
>  
> @@ -768,16 +778,18 @@ DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
>  		__entry->new_blkaddr	= fio->new_blkaddr;
>  		__entry->op		= fio->op;
>  		__entry->op_flags	= fio->op_flags;
> +		__entry->temp		= fio->temp;
>  		__entry->type		= fio->type;
>  	),
>  
>  	TP_printk("dev = (%d,%d), ino = %lu, page_index = 0x%lx, "
> -		"oldaddr = 0x%llx, newaddr = 0x%llx, rw = %s(%s), type = %s",
> +		"oldaddr = 0x%llx, newaddr = 0x%llx, rw = %s(%s), type = %s_%s",
>  		show_dev_ino(__entry),
>  		(unsigned long)__entry->index,
>  		(unsigned long long)__entry->old_blkaddr,
>  		(unsigned long long)__entry->new_blkaddr,
>  		show_bio_type(__entry->op, __entry->op_flags),
> +		show_block_temp(__entry->temp),
>  		show_block_type(__entry->type))
>  );
>  
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
