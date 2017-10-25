From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: modify for accurate fggc node io
 stat
Date: Wed, 25 Oct 2017 13:51:07 +0800
Message-ID: <726a1de9-9f2c-b477-94e9-df6ead5ef35d@huawei.com>
References: <1508900703-30453-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e7EbG-0004IZ-Df
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Oct 2017 05:51:34 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e7EbE-0003Wf-Vc
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Oct 2017 05:51:34 +0000
In-Reply-To: <1508900703-30453-1-git-send-email-heyunlei@huawei.com>
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
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: ning.jia@huawei.com

On 2017/10/25 11:05, Yunlei He wrote:
> modify for accurate fggc node io stat
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/node.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index f44d837..f4f2894 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1259,7 +1259,7 @@ void move_node_page(struct page *node_page, int gc_type)
>  		if (!clear_page_dirty_for_io(node_page))
>  			goto out_page;
>  
> -		if (NODE_MAPPING(sbi)->a_ops->writepage(node_page, &wbc))
> +		if (__write_node_page(page, false, NULL, &wbc, false, FS_GC_NODE_IO))

There are some compile errors, and please don't make line being over 80 column
as much as possible to keep code style consistent.

Thanks,

>  			unlock_page(node_page);
>  		goto release_page;
>  	} else {
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
