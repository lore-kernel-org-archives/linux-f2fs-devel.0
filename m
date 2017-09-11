From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/2] f2fs: better to wait for fstrim
 completion
Date: Mon, 11 Sep 2017 18:35:10 +0800
Message-ID: <4a84e552-d18a-4b13-8a10-f480cd542681@huawei.com>
References: <20170909191710.81288-1-jaegeuk@kernel.org>
 <20170909191710.81288-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1drM3q-0000N6-Mr
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Sep 2017 10:35:26 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1drM3p-00025a-F5
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Sep 2017 10:35:26 +0000
In-Reply-To: <20170909191710.81288-2-jaegeuk@kernel.org>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/9/10 3:17, Jaegeuk Kim wrote:
> In android, we'd better wait for fstrim completion instead of issuing the
> discard commands asynchronous.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> ---
>  fs/f2fs/segment.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index f96e61e8ddf7..beb15c834a34 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1076,6 +1076,9 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
>  			if (dcc->pend_list_tag[i] & P_TRIM) {
>  				__submit_discard_cmd(sbi, dc);
>  				issued++;
> +
> +				if (fatal_signal_pending(current))
> +					break;
>  				continue;
>  			}
>  
> @@ -1192,7 +1195,7 @@ void stop_discard_thread(struct f2fs_sb_info *sbi)
>  	}
>  }
>  
> -/* This comes from f2fs_put_super */
> +/* This comes from f2fs_put_super and f2fs_trim_fs */
>  void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
>  {
>  	__issue_discard_cmd(sbi, false);
> @@ -2227,6 +2230,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
>  	}
>  	/* It's time to issue all the filed discards */
>  	mark_discard_range_all(sbi);
> +	f2fs_wait_discard_bios(sbi);
>  out:
>  	range->len = F2FS_BLK_TO_BYTES(cpc.trimmed);
>  	return err;
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
