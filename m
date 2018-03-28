From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: rebuild get_node_path function
Date: Wed, 28 Mar 2018 09:41:26 +0800
Message-ID: <be57d93a-93c3-4b13-58d1-ed348eb2bc28@huawei.com>
References: <1521689502-6040-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f105w-0003kn-8F
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Mar 2018 01:41:44 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f105s-00EwJl-CR
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Mar 2018 01:41:44 +0000
In-Reply-To: <1521689502-6040-1-git-send-email-heyunlei@huawei.com>
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

On 2018/3/22 11:31, Yunlei He wrote:
> This patch rebuild get_node_path function, no logic changes.
> 
> v1->v2: '<' has higher priority than '-='

It looks that after the cleanup, the code logic would not be more understandable
than before, since we'd better to avoid doing calculation inside if condition.

Thanks,

> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/node.c | 28 ++++++----------------------
>  1 file changed, 6 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index c511ef6..b8f2577 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -526,46 +526,31 @@ static int get_node_path(struct inode *inode, long block,
>  
>  	if (block < direct_index) {
>  		offset[n] = block;
> -		goto got;
> -	}
> -	block -= direct_index;
> -	if (block < direct_blks) {
> +	} else if ((block -= direct_index) < direct_blks) {
>  		offset[n++] = NODE_DIR1_BLOCK;
>  		noffset[n] = 1;
>  		offset[n] = block;
>  		level = 1;
> -		goto got;
> -	}
> -	block -= direct_blks;
> -	if (block < direct_blks) {
> +	} else if ((block -= direct_blks) < direct_blks) {
>  		offset[n++] = NODE_DIR2_BLOCK;
>  		noffset[n] = 2;
>  		offset[n] = block;
>  		level = 1;
> -		goto got;
> -	}
> -	block -= direct_blks;
> -	if (block < indirect_blks) {
> +	} else if ((block -= direct_blks) < indirect_blks) {
>  		offset[n++] = NODE_IND1_BLOCK;
>  		noffset[n] = 3;
>  		offset[n++] = block / direct_blks;
>  		noffset[n] = 4 + offset[n - 1];
>  		offset[n] = block % direct_blks;
>  		level = 2;
> -		goto got;
> -	}
> -	block -= indirect_blks;
> -	if (block < indirect_blks) {
> +	} else if ((block -= indirect_blks) < indirect_blks) {
>  		offset[n++] = NODE_IND2_BLOCK;
>  		noffset[n] = 4 + dptrs_per_blk;
>  		offset[n++] = block / direct_blks;
>  		noffset[n] = 5 + dptrs_per_blk + offset[n - 1];
>  		offset[n] = block % direct_blks;
>  		level = 2;
> -		goto got;
> -	}
> -	block -= indirect_blks;
> -	if (block < dindirect_blks) {
> +	} else if ((block -= indirect_blks) < dindirect_blks) {
>  		offset[n++] = NODE_DIND_BLOCK;
>  		noffset[n] = 5 + (dptrs_per_blk * 2);
>  		offset[n++] = block / indirect_blks;
> @@ -577,11 +562,10 @@ static int get_node_path(struct inode *inode, long block,
>  			      offset[n - 1];
>  		offset[n] = block % direct_blks;
>  		level = 3;
> -		goto got;
>  	} else {
>  		return -E2BIG;
>  	}
> -got:
> +
>  	return level;
>  }
>  
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
