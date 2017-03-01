From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: skip writeback meta pages if cp_mutex
 acquire failed
Date: Wed, 1 Mar 2017 17:32:07 +0800
Message-ID: <79c52d55-2270-beab-5fe8-3d5cda987840@huawei.com>
References: <20170301092126.8816-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cj0cz-0006Pv-4g
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Mar 2017 09:32:57 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cj0cw-0000cY-AH
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Mar 2017 09:32:57 +0000
In-Reply-To: <20170301092126.8816-1-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/3/1 17:21, Yunlei He wrote:
> Skip writeback meta pages if cp_mutex lock acquire failed, cp will
> flush dirty pages instead.

Make sense to me. :)

> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/checkpoint.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 0339daf..5ce24b1 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -275,13 +275,15 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
>  		get_pages(sbi, F2FS_DIRTY_META) < nr_pages_to_skip(sbi, META))
>  		goto skip_write;
>  
> -	trace_f2fs_writepages(mapping->host, wbc, META);
> +	/* if locked failed, cp will flush dirty pages instead */
> +	if (mutex_trylock(&sbi->cp_mutex)) {
> +		diff = nr_pages_to_write(sbi, META, wbc);
> +		written = sync_meta_pages(sbi, META, wbc->nr_to_write);
> +	} else
> +		goto skip_write;

Would it be better to change:

/* your comments */
if (!mutex_trylock(&sbi->cp_mutex))
	goto skip_write;

trace_f2fs_writepages();
diff = nr_pages_to_write();
...

Thanks,

>  
> -	/* if mounting is failed, skip writing node pages */
> -	mutex_lock(&sbi->cp_mutex);
> -	diff = nr_pages_to_write(sbi, META, wbc);
> -	written = sync_meta_pages(sbi, META, wbc->nr_to_write);
>  	mutex_unlock(&sbi->cp_mutex);
> +	trace_f2fs_writepages(mapping->host, wbc, META);
>  	wbc->nr_to_write = max((long)0, wbc->nr_to_write - written - diff);
>  	return 0;
>  
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
