From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: make sure trace all f2fs_issue_flush
Date: Mon, 6 Mar 2017 19:10:01 +0800
Message-ID: <2060f8e5-fef3-825c-046a-d42b7b140757@huawei.com>
References: <bec97aa1-52a5-b76f-d910-5267ff3e55c4@gmail.com>
	<c97108ed-6c4e-6daa-af98-b850a2e56eed@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1ckqWt-0000AX-5b
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 06 Mar 2017 11:10:15 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ckqWr-0002hl-Mh
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 06 Mar 2017 11:10:15 +0000
In-Reply-To: <c97108ed-6c4e-6daa-af98-b850a2e56eed@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kinglong Mee <kinglongmee@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On 2017/3/4 22:13, Kinglong Mee wrote:
> The root device's issue flush trace is missing,
> add it and tracing the result from submit.
> 
> Fixes d50aaeec90 ("f2fs: show actual device info in tracepoints")
> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/segment.c           | 24 +++++++++++++-----------
>  include/trace/events/f2fs.h | 11 +++++++----
>  2 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index ed181d1..94bc8ac 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -411,7 +411,8 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
>  	}
>  }
>  
> -static int __submit_flush_wait(struct block_device *bdev)
> +static int __submit_flush_wait(struct f2fs_sb_info *sbi,
> +				struct block_device *bdev)
>  {
>  	struct bio *bio = f2fs_bio_alloc(0);
>  	int ret;
> @@ -420,23 +421,24 @@ static int __submit_flush_wait(struct block_device *bdev)
>  	bio->bi_bdev = bdev;
>  	ret = submit_bio_wait(bio);
>  	bio_put(bio);
> +
> +	trace_f2fs_issue_flush(bdev, test_opt(sbi, NOBARRIER),
> +				test_opt(sbi, FLUSH_MERGE), ret);
>  	return ret;
>  }
>  
>  static int submit_flush_wait(struct f2fs_sb_info *sbi)
>  {
> -	int ret = __submit_flush_wait(sbi->sb->s_bdev);
> +	int ret = __submit_flush_wait(sbi, sbi->sb->s_bdev);
>  	int i;
>  
> -	if (sbi->s_ndevs && !ret) {
> -		for (i = 1; i < sbi->s_ndevs; i++) {
> -			trace_f2fs_issue_flush(FDEV(i).bdev,
> -					test_opt(sbi, NOBARRIER),
> -					test_opt(sbi, FLUSH_MERGE));
> -			ret = __submit_flush_wait(FDEV(i).bdev);
> -			if (ret)
> -				break;
> -		}
> +	if (!sbi->s_ndevs || ret)
> +		return ret;
> +
> +	for (i = 1; i < sbi->s_ndevs; i++) {
> +		ret = __submit_flush_wait(sbi, FDEV(i).bdev);
> +		if (ret)
> +			break;
>  	}
>  	return ret;
>  }
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index c80fcad0..d799ca7 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -1174,26 +1174,29 @@ TRACE_EVENT(f2fs_issue_reset_zone,
>  TRACE_EVENT(f2fs_issue_flush,
>  
>  	TP_PROTO(struct block_device *dev, unsigned int nobarrier,
> -					unsigned int flush_merge),
> +				unsigned int flush_merge, int ret),
>  
> -	TP_ARGS(dev, nobarrier, flush_merge),
> +	TP_ARGS(dev, nobarrier, flush_merge, ret),
>  
>  	TP_STRUCT__entry(
>  		__field(dev_t,	dev)
>  		__field(unsigned int, nobarrier)
>  		__field(unsigned int, flush_merge)
> +		__field(int,  ret)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->dev	= dev->bd_dev;
>  		__entry->nobarrier = nobarrier;
>  		__entry->flush_merge = flush_merge;
> +		__entry->ret = ret;
>  	),
>  
> -	TP_printk("dev = (%d,%d), %s %s",
> +	TP_printk("dev = (%d,%d), %s %s, ret = %d",
>  		show_dev(__entry->dev),
>  		__entry->nobarrier ? "skip (nobarrier)" : "issue",
> -		__entry->flush_merge ? " with flush_merge" : "")
> +		__entry->flush_merge ? " with flush_merge" : "",
> +		__entry->ret)
>  );
>  
>  TRACE_EVENT(f2fs_lookup_extent_tree_start,
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
