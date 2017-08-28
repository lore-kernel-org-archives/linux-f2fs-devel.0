From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] mkfs.f2fs: fix wrong curseg check
Date: Mon, 28 Aug 2017 17:47:01 +0800
Message-ID: <34b9300b-47e9-3736-7429-1cfbbf864999@huawei.com>
References: <20170826001055.4478-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dmGdc-0003Nj-GI
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Aug 2017 09:47:20 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dmGdb-0004dO-JN
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Aug 2017 09:47:20 +0000
In-Reply-To: <20170826001055.4478-1-jaegeuk@kernel.org>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On 2017/8/26 8:10, Jaegeuk Kim wrote:
> We should avoid i==j, otherwise we always assign 0~5 segments.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> ---
>  mkfs/f2fs_format.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index b379e80..219c2a7 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -123,7 +123,7 @@ static void verify_cur_segs(void)
>  
>  	for (i = 0; i < NR_CURSEG_TYPE; i++) {
>  		for (j = 0; j < NR_CURSEG_TYPE; j++)
> -			if (c.cur_seg[i] == c.cur_seg[j])
> +			if (i != j && c.cur_seg[i] == c.cur_seg[j])
>  				break;
>  	}
>  
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
