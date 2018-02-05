From: guoweichao <guoweichao@huawei.com>
Subject: Re: [PATCH] f2fs: no need to flush NAT bits if no enough
 space
Date: Mon, 5 Feb 2018 14:29:02 +0800
Message-ID: <052906a5-7199-a98c-6348-7f145c99d3b2@huawei.com>
References: <20180205143050.190788-1-guoweichao@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <guoweichao@huawei.com>) id 1eiaHm-0003B2-H3
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Feb 2018 06:29:50 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eiaHk-0000Lo-4U
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Feb 2018 06:29:50 +0000
In-Reply-To: <20180205143050.190788-1-guoweichao@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net


On 2018/2/5 22:30, Weichao Guo wrote:
> NAT bits are saved at spare space in CP pack. Flushed NAT bits
> may be overwritten by the CP pack if there is no enough space
> for NAT bits. And NAT bits will be obsolesced at next mount time
Sorry, there is a typo here. 'obsolesced' should be obsolete.

Thanks,

> if crc|cp_ver not matched. So just skip to flush NAT bits in such
> needless cases.
> 
> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
> ---
>  fs/f2fs/checkpoint.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 0eaafb8..bdc03c9 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1248,7 +1248,9 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	start_blk = __start_cp_next_addr(sbi);
>  
>  	/* write nat bits */
> -	if (enabled_nat_bits(sbi, cpc)) {
> +	if (enabled_nat_bits(sbi, cpc) &&
> +			le32_to_cpu(ckpt->cp_pack_total_block_count) <=
> +			sbi->blocks_per_seg - NM_I(sbi)->nat_bits_blocks) {
>  		__u64 cp_ver = cur_cp_version(ckpt);
>  		block_t blk;
>  
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
