From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: skip searching non-exist range in
 truncate_hole
Date: Mon, 16 Oct 2017 11:15:39 +0800
Message-ID: <a7af0c71-9f6b-49a1-988c-757c8345f21b@huawei.com>
References: <20171014001332.2647-1-guoweichao@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e3vsh-0004e8-Js
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 Oct 2017 03:15:55 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e3vsg-0006Td-Jw
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 Oct 2017 03:15:55 +0000
In-Reply-To: <20171014001332.2647-1-guoweichao@huawei.com>
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
To: Weichao Guo <guoweichao@huawei.com>, jaegeuk@kernel.org
Cc: heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2017/10/14 8:13, Weichao Guo wrote:
> Let's skip entire non-exist area to speed up truncate_hole by
> using get_next_page_offset.
> 
> Signed-off-by: Weichao Guo <guoweichao@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 517e112..819c29a 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -844,7 +844,7 @@ int truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end)
>  		err = get_dnode_of_data(&dn, pg_start, LOOKUP_NODE);
>  		if (err) {
>  			if (err == -ENOENT) {
> -				pg_start++;
> +				pg_start = get_next_page_offset(&dn, pg_start);
>  				continue;
>  			}
>  			return err;
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
