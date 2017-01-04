From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 03/10] f2fs: add submit_bio tracepoint
Date: Wed, 4 Jan 2017 11:32:53 +0800
Message-ID: <5bb8933f-9b6e-cf61-beec-d328f41b4616@huawei.com>
References: <20161230185117.3832-1-jaegeuk@kernel.org>
 <20161230185117.3832-3-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20161230185117.3832-3-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2016/12/31 2:51, Jaegeuk Kim wrote:
> This patch adds final submit_bio() tracepoint.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c              |  1 +
>  include/trace/events/f2fs.h | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 2c5df1dc1479..54da4e2f1318 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -175,6 +175,7 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
>  			current->plug && (type == DATA || type == NODE))
>  			blk_finish_plug(current->plug);
>  	}
> +	trace_f2fs_submit_bio(sbi->sb, bio);
>  	submit_bio(bio);
>  }
>  
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index 4c942599581b..094d92b52450 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -55,6 +55,8 @@ TRACE_DEFINE_ENUM(CP_DISCARD);
>  		{ IPU,		"IN-PLACE" },				\
>  		{ OPU,		"OUT-OF-PLACE" })
>  
> +#define F2FS_OP	(REQ_OP_READ | REQ_OP_RAHEAD | REQ_SYNC | REQ_PREFLUSH | REQ_META |\
> +			REQ_PRIO)

Needed?

>  #define F2FS_OP_FLAGS (REQ_RAHEAD | REQ_SYNC | REQ_PREFLUSH | REQ_META |\
>  			REQ_PRIO)
>  #define F2FS_BIO_FLAG_MASK(t)	(t & F2FS_OP_FLAGS)
> @@ -837,6 +839,35 @@ DEFINE_EVENT_CONDITION(f2fs__submit_bio, f2fs_submit_read_bio,
>  	TP_CONDITION(bio)
>  );
>  
> +TRACE_EVENT(f2fs_submit_bio,

Can we reuse f2fs__submit_bio class like f2fs_submit_{read,write}_bio?

DEFINE_EVENT_CONDITION(f2fs__submit_bio, f2fs_submit_last_bio,

Thanks,

> +
> +	TP_PROTO(struct super_block *sb, struct bio *bio),
> +
> +	TP_ARGS(sb, bio),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t,	dev)
> +		__field(int,	op)
> +		__field(int,	op_flags)
> +		__field(sector_t,	sector)
> +		__field(unsigned int,	size)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev		= sb->s_dev;
> +		__entry->op		= bio->bi_opf & REQ_OP_MASK;
> +		__entry->op_flags	= bio->bi_opf;
> +		__entry->sector		= bio->bi_iter.bi_sector;
> +		__entry->size		= bio->bi_iter.bi_size;
> +	),
> +
> +	TP_printk("dev = (%d,%d), rw = %s%s, sector = %lld, size = %u",
> +		show_dev(__entry),
> +		show_bio_type(__entry->op, __entry->op_flags),
> +		(unsigned long long)__entry->sector,
> +		__entry->size)
> +);
> +
>  TRACE_EVENT(f2fs_write_begin,
>  
>  	TP_PROTO(struct inode *inode, loff_t pos, unsigned int len,
> 

