From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 2/3] f2fs: still write data if preallocate
 only partial blocks
Date: Thu, 23 Nov 2017 21:17:11 +0800
Message-ID: <3ddc7b22-730c-2e2f-718c-c728a29ca841@kernel.org>
References: <20171122102340.133491-1-shengyong1@huawei.com>
 <20171122102340.133491-2-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1eHrNj-0006ME-UL
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Nov 2017 13:17:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eHrNi-0008KT-Re
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Nov 2017 13:17:31 +0000
In-Reply-To: <20171122102340.133491-2-shengyong1@huawei.com>
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
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/11/22 18:23, Sheng Yong wrote:
> If there is not enough space left, f2fs_preallocate_blocks may only
> preallocte partial blocks. As a result, the write operation fails
> but i_blocks is not 0.  To avoid this, f2fs should write data in
> non-preallocation way and write as many data as the size of i_blocks.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/data.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index b0781edc9ada..e593df628158 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -862,8 +862,14 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>  		if (err)
>  			return err;
>  	}
> -	if (!f2fs_has_inline_data(inode))
> -		return f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
> +	if (!f2fs_has_inline_data(inode)) {
> +		err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
> +		if (map.m_len > 0 && err == -ENOSPC) {
> +			set_inode_flag(inode, FI_NO_PREALLOC);
> +			err = 0;
> +		}
> +		return err;
> +	}
>  	return err;
>  }
>  
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
