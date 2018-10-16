From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: remove request_list check in is_idle()
Date: Wed, 17 Oct 2018 00:06:45 +0800
Message-ID: <003df7ce-626c-e32b-909b-909b87e0c8f3@kernel.org>
References: <d89936bb-398e-08c1-573f-b1bd54f3ca35@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1gCRsE-0000PU-DT
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Oct 2018 16:07:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gCRsD-002nd3-1I
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Oct 2018 16:07:10 +0000
In-Reply-To: <d89936bb-398e-08c1-573f-b1bd54f3ca35@kernel.dk>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jens Axboe <axboe@kernel.dk>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Hi Jens,

On 2018-10-16 22:34, Jens Axboe wrote:
> This doesn't work on stacked devices, and it doesn't work on
> blk-mq devices. The request_list is only used on legacy, which
> we don't have much of anymore, and soon won't have any of.
> 
> Kill the check.

In order to avoid conflicting with user IO, GC and Discard thread try to be
aware of IO status of device by is_idle(), if previous implementation doesn't
work, do we have any other existing method to get such status? Or do you have
any suggestion on this?

Thanks,

> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/f2fs/f2fs.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index abf925664d9c..58778992eca4 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1356,13 +1356,6 @@ static inline bool f2fs_time_over(struct f2fs_sb_info *sbi, int type)
>  
>  static inline bool is_idle(struct f2fs_sb_info *sbi)
>  {
> -	struct block_device *bdev = sbi->sb->s_bdev;
> -	struct request_queue *q = bdev_get_queue(bdev);
> -	struct request_list *rl = &q->root_rl;
> -
> -	if (rl->count[BLK_RW_SYNC] || rl->count[BLK_RW_ASYNC])
> -		return false;
> -
>  	return f2fs_time_over(sbi, REQ_TIME);
>  }
>  
> 
