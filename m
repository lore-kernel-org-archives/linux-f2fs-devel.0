From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix to release inode page in
	get_new_data_page
Date: Fri, 10 Jul 2015 17:17:15 -0700
Message-ID: <20150711001715.GA61190@jaegeuk-mac02>
References: <00f301d0ba30$ebe95b80$c3bc1280$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZDiTt-0006sr-5t
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 11 Jul 2015 00:17:25 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZDiTs-0008Km-3P for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 11 Jul 2015 00:17:25 +0000
Content-Disposition: inline
In-Reply-To: <00f301d0ba30$ebe95b80$c3bc1280$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On Thu, Jul 09, 2015 at 06:20:08PM +0800, Chao Yu wrote:
> get_new_data_page should release inode page when we encounter any
> error in its procedure, but there is one error path didn't cover
> this, fix it.

Nice catch.
But, I think we should fix its caller:

in init_inode_metadata(),
	err = make_empty_dir();
	if (err)
		goto put_error;
		---------------
Thanks,

> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/data.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 08dfdc6..ea8898b 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -397,8 +397,10 @@ struct page *get_new_data_page(struct inode *inode,
>  	int err;
>  repeat:
>  	page = grab_cache_page(mapping, index);
> -	if (!page)
> +	if (!page) {
> +		f2fs_put_page(ipage, 1);
>  		return ERR_PTR(-ENOMEM);
> +	}
>  
>  	set_new_dnode(&dn, inode, ipage, NULL, 0);
>  	err = f2fs_reserve_block(&dn, index);
> -- 
> 2.4.2

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
