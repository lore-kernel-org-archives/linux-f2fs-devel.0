From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RFC PATCH] f2fs-tools: fix blocks allocation
 direction inside segment
Date: Mon, 14 May 2018 16:09:01 +0800
Message-ID: <95fbd76a-a4ec-e678-a074-e95612ba37bf@huawei.com>
References: <20180508141659.118390-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fI8Xq-0005PG-AB
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 14 May 2018 08:09:22 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fI8Xn-000pHX-C0
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 14 May 2018 08:09:22 +0000
In-Reply-To: <20180508141659.118390-1-zhengjunling@huawei.com>
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
To: Junling Zheng <zhengjunling@huawei.com>, jaegeuk@kernel.org
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/5/8 22:16, Junling Zheng wrote:
> This fixes the block allocation direction from left to right inside
> one segment despite of the direction of segment allocation.

Hmm.. there is no such restriction that we have to keep misc tools' allocation
algorithm line with kernel one, so I suggest that let's just keep original
codes. Jaegeuk, what's your opinion?

Thanks,

> 
> Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
> ---
>  fsck/mount.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fsck/mount.c b/fsck/mount.c
> index 1396a2e..38d2aa2 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -1921,13 +1921,13 @@ int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left, int type)
>  
>  		if (se->valid_blocks == sbi->blocks_per_seg ||
>  				IS_CUR_SEGNO(sbi, segno, type)) {
> -			*to = left ? START_BLOCK(sbi, segno) - 1:
> +			*to = left ? START_BLOCK(sbi, segno - 1) :
>  						START_BLOCK(sbi, segno + 1);
>  			continue;
>  		}
>  
>  		if (se->valid_blocks == 0 && not_enough) {
> -			*to = left ? START_BLOCK(sbi, segno) - 1:
> +			*to = left ? START_BLOCK(sbi, segno - 1) :
>  						START_BLOCK(sbi, segno + 1);
>  			continue;
>  		}
> @@ -1949,7 +1949,10 @@ int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left, int type)
>  			!f2fs_test_bit(offset, (const char *)se->cur_valid_map))
>  			return 0;
>  
> -		*to = left ? *to - 1: *to + 1;
> +		if (!(OFFSET_IN_SEG(sbi, *to + 1)) && left)
> +			*to = START_BLOCK(sbi, segno - 1);
> +		else
> +			*to = *to + 1;
>  	}
>  	return -1;
>  }
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
