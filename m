From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/3] f2fs: enhance scalability of trace macro
Date: Wed, 3 May 2017 11:47:10 -0700
Message-ID: <20170503184710.GA96113@jaegeuk.local>
References: <20170503155914.6859-1-chao@kernel.org>
 <20170503155914.6859-3-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170503155914.6859-3-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On 05/03, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> Use __print_flags in show_bio_op_flags and show_cpreason instead of
> __print_symbolic, it enables tracer function traverses and shows all
> bits in the flag.
> 
> Additionally, add missing REQ_FUA into F2FS_OP_FLAGS.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  include/trace/events/f2fs.h | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index c78a223a0d9c..ad4cbeeeef44 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -59,8 +59,8 @@ TRACE_DEFINE_ENUM(CP_TRIMMED);
>  		{ IPU,		"IN-PLACE" },				\
>  		{ OPU,		"OUT-OF-PLACE" })
>  
> -#define F2FS_OP_FLAGS (REQ_RAHEAD | REQ_SYNC | REQ_PREFLUSH | REQ_META |\
> -			REQ_PRIO)
> +#define F2FS_OP_FLAGS (REQ_RAHEAD | REQ_SYNC | REQ_META | REQ_PRIO |	\
> +			REQ_PREFLUSH | REQ_FUA)
>  #define F2FS_BIO_FLAG_MASK(t)	(t & F2FS_OP_FLAGS)
>  
>  #define show_bio_type(op,op_flags)	show_bio_op(op),		\
> @@ -79,15 +79,13 @@ TRACE_DEFINE_ENUM(CP_TRIMMED);
>  		{ REQ_OP_WRITE_ZEROES,		"WRITE_ZEROES" })
>  
>  #define show_bio_op_flags(flags)					\
> -	__print_symbolic(F2FS_BIO_FLAG_MASK(flags),			\
> -		{ REQ_RAHEAD, 		"(RA)" },			\
> -		{ REQ_SYNC, 		"(S)" },			\
> -		{ REQ_SYNC | REQ_PRIO,	"(SP)" },			\
> -		{ REQ_META, 		"(M)" },			\
> -		{ REQ_META | REQ_PRIO,	"(MP)" },			\
> -		{ REQ_SYNC | REQ_PREFLUSH , "(SF)" },			\
> -		{ REQ_SYNC | REQ_META | REQ_PRIO, "(SMP)" },		\
> -		{ REQ_PREFLUSH | REQ_META | REQ_PRIO, "(FMP)" },	\
> +	__print_flags(F2FS_BIO_FLAG_MASK(flags), "|",			\
> +		{ REQ_RAHEAD,		"R" },				\
> +		{ REQ_SYNC,		"S" },				\
> +		{ REQ_META,		"M" },				\
> +		{ REQ_PRIO,		"P" },				\
> +		{ REQ_PREFLUSH,		"PF" },				\
> +		{ REQ_FUA,		"FUA" },			\
>  		{ 0, " \b" })

We don't need the above last entry.

>  
>  #define show_data_type(type)						\
> @@ -121,13 +119,14 @@ TRACE_DEFINE_ENUM(CP_TRIMMED);
>  		{ GC_CB,	"Cost-Benefit" })
>  
>  #define show_cpreason(type)						\
> -	__print_symbolic(type,						\
> +	__print_flags(type, "|",					\
>  		{ CP_UMOUNT,	"Umount" },				\
>  		{ CP_FASTBOOT,	"Fastboot" },				\
>  		{ CP_SYNC,	"Sync" },				\
>  		{ CP_RECOVERY,	"Recovery" },				\
>  		{ CP_DISCARD,	"Discard" },				\
> -		{ CP_UMOUNT | CP_TRIMMED,	"Umount,Trimmed" })
> +		{ CP_UMOUNT,	"Umount" },				\
> +		{ CP_TRIMMED,	"Trimmed" })
>  
>  struct victim_sel_policy;
>  struct f2fs_map_blocks;
> @@ -774,7 +773,7 @@ DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
>  	),
>  
>  	TP_printk("dev = (%d,%d), ino = %lu, page_index = 0x%lx, "
> -		"oldaddr = 0x%llx, newaddr = 0x%llx, rw = %s%s, type = %s",
> +		"oldaddr = 0x%llx, newaddr = 0x%llx, rw = %s,%s, type = %s",

How about showing this like %s(%s) ?

>  		show_dev_ino(__entry),
>  		(unsigned long)__entry->index,
>  		(unsigned long long)__entry->old_blkaddr,
> @@ -827,7 +826,7 @@ DECLARE_EVENT_CLASS(f2fs__bio,
>  		__entry->size		= bio->bi_iter.bi_size;
>  	),
>  
> -	TP_printk("dev = (%d,%d)/(%d,%d), rw = %s%s, %s, sector = %lld, size = %u",
> +	TP_printk("dev = (%d,%d)/(%d,%d), rw = %s,%s, %s, sector = %lld, size = %u",

ditto.

Thanks,

>  		show_dev(__entry->target),
>  		show_dev(__entry->dev),
>  		show_bio_type(__entry->op, __entry->op_flags),
> -- 
> 2.12.2.575.gb14f27f
