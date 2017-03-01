From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix an error return value in
 truncate_partial_data_page
Date: Wed, 1 Mar 2017 10:48:35 +0800
Message-ID: <98366c6a-4bcd-44cc-4143-a22a359db63d@huawei.com>
References: <20170228123241.5070-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1ciuKA-00053p-FM
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Mar 2017 02:49:06 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ciuK5-0002JI-OC
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Mar 2017 02:49:06 +0000
In-Reply-To: <20170228123241.5070-1-heyunlei@huawei.com>
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

On 2017/2/28 20:32, Yunlei He wrote:
> This patch fix a error return value in truncate_partial_data_page
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index c6ca00c..c186d75 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -529,7 +529,7 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
>  
>  	page = get_lock_data_page(inode, index, true);
>  	if (IS_ERR(page))
> -		return 0;
> +		return page;

return PTR_ERR(page);

Thanks,

>  truncate_out:
>  	f2fs_wait_on_page_writeback(page, DATA, true);
>  	zero_user(page, offset, PAGE_SIZE - offset);
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
