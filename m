From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: check if inmem_pages list is empty
 correctly
Date: Tue, 17 Apr 2018 17:55:14 +0800
Message-ID: <79719f3d-fa2f-786e-a7bd-e2c3096b5010@huawei.com>
References: <20180417091227.33702-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f8NPB-0003yX-1c
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Apr 2018 10:00:05 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f8NKx-00CBzx-AM
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Apr 2018 10:00:04 +0000
In-Reply-To: <20180417091227.33702-1-shengyong1@huawei.com>
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
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/4/17 17:12, Sheng Yong wrote:
> `cur' will never be NULL, we should check inmem_pages list instead.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/segment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 5854cc4e1d67..bf9dab55b370 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -328,7 +328,7 @@ void drop_inmem_page(struct inode *inode, struct page *page)
>  			break;
>  	}
>  
> -	f2fs_bug_on(sbi, !cur || cur->page != page);
> +	f2fs_bug_on(sbi, list_empty(head) || cur->page != page);
>  	list_del(&cur->list);
>  	mutex_unlock(&fi->inmem_lock);
>  
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
