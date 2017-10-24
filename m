From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: modify for accurate fggc node io stat
Date: Tue, 24 Oct 2017 22:03:22 +0800
Message-ID: <342fdd48-e147-1346-95d2-cb2c84db8b43@kernel.org>
References: <1508841248-13825-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1e6znz-0003aX-FR
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Oct 2017 14:03:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e6znt-0006Gq-Hc
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Oct 2017 14:03:43 +0000
In-Reply-To: <1508841248-13825-1-git-send-email-heyunlei@huawei.com>
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
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, yuchao0@huawei.com
Cc: ning.jia@huawei.com

On 2017/10/24 18:34, Yunlei He wrote:
> modify for accurate fggc node io stat
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/node.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index f44d837..daa9086 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1259,7 +1259,7 @@ void move_node_page(struct page *node_page, int gc_type)
>  		if (!clear_page_dirty_for_io(node_page))
>  			goto out_page;
>  
> -		if (NODE_MAPPING(sbi)->a_ops->writepage(node_page, &wbc))
> +		if (__write_node_page(page, false, NULL, wbc, false, FS_GC_NODE_IO))

&wbc

Thanks,

>  			unlock_page(node_page);
>  		goto release_page;
>  	} else {
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
