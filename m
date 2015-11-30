From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-linux 3.10][PATCH] f2fs: Fix a system panic
 caused by f2fs_follow_link
Date: Mon, 30 Nov 2015 15:14:37 -0800
Message-ID: <20151130231437.GA49656@jaegeuk.local>
References: <1448692720-16658-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a3Xeh-0000F9-9S
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 30 Nov 2015 23:14:47 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a3Xeg-00086D-01 for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 30 Nov 2015 23:14:47 +0000
Content-Disposition: inline
In-Reply-To: <1448692720-16658-1-git-send-email-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>
Cc: Shuoran Liu <liushuoran@huawei.com>, linux-f2fs-devel@lists.sourceforge.net

Hi Yunlei,

Merged into the new 3.10 repo:

http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-stable.git/log/?h=linux-3.10.y

Thanks,

On Sat, Nov 28, 2015 at 02:38:40PM +0800, Yunlei He wrote:
> In linux 3.10, we can not make sure the return value of nd_get_link function
> is valid. So this patch add a check before use it.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> Signed-off-by: Shuoran Liu <liushuoran@huawei.com>
> 
> ---
>  fs/f2fs/namei.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 336d43d..bfaec10 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -319,13 +319,18 @@ fail:
>  static void *f2fs_follow_link(struct dentry *dentry, struct nameidata *nd)
>  {
>  	struct page *page;
> +	char *link;
>  
>  	page = page_follow_link_light(dentry, nd);
>  	if (IS_ERR(page))
>  		return page;
>  
> +	link = nd_get_link(nd);
> +	if (IS_ERR(link))
> +		return link;
> +
>  	/* this is broken symlink case */
> -	if (*nd_get_link(nd) == 0) {
> +	if (*link == 0) {
>  		kunmap(page);
>  		page_cache_release(page);
>  		return ERR_PTR(-ENOENT);
> -- 
> 1.9.1

------------------------------------------------------------------------------
Go from Idea to Many App Stores Faster with Intel(R) XDK
Give your users amazing mobile app experiences with Intel(R) XDK.
Use one codebase in this all-in-one HTML5 development environment.
Design, debug & build mobile apps & 2D/3D high-impact games for multiple OSs.
http://pubads.g.doubleclick.net/gampad/clk?id=254741911&iu=/4140
