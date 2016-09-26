From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: fix to commit bio cache after
 flushing node pages
Date: Mon, 26 Sep 2016 11:33:21 -0700
Message-ID: <20160926183321.GB33149@jaegeuk>
References: <1474906193-6487-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1boaiZ-0001Mk-81
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Sep 2016 18:33:31 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1boaiY-0002SL-Gu
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Sep 2016 18:33:31 +0000
Content-Disposition: inline
In-Reply-To: <1474906193-6487-1-git-send-email-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On Tue, Sep 27, 2016 at 12:09:52AM +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> In sync_node_pages, we won't check and commit last merged pages in private
> bio cache of f2fs, as these pages were taged as writeback, someone who is
> waiting for writebacking of the page will be blocked until the cache was
> committed by someone else.
> 
> We need to commit node type bio cache to avoid potential deadlock or long
> delay of waiting writeback.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/node.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 9faddcd..f73f774 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1416,6 +1416,7 @@ int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc)
>  	struct pagevec pvec;
>  	int step = 0;
>  	int nwritten = 0;
> +	int ret = 0;
>  
>  	pagevec_init(&pvec, 0);
>  
> @@ -1436,7 +1437,8 @@ next_step:
>  
>  			if (unlikely(f2fs_cp_error(sbi))) {
>  				pagevec_release(&pvec);
> -				return -EIO;
> +				ret = -EIO;
> +				goto out;
>  			}
>  
>  			/*
> @@ -1487,6 +1489,8 @@ continue_unlock:
>  
>  			if (NODE_MAPPING(sbi)->a_ops->writepage(page, wbc))
>  				unlock_page(page);
> +			else
> +				nwritten++;
>  
>  			if (--wbc->nr_to_write == 0)
>  				break;
> @@ -1504,7 +1508,10 @@ continue_unlock:
>  		step++;
>  		goto next_step;
>  	}
> -	return nwritten;
> +out:
> +	if (nwritten)
> +		f2fs_submit_merged_bio(sbi, NODE, WRITE);

IIRC, we don't need to flush this, since f2fs_submit_merged_bio_cond() would
handle this in f2fs_wait_on_page_writeback().

Thanks,

> +	return ret;
>  }
>  
>  int wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
> -- 
> 2.7.2

------------------------------------------------------------------------------
