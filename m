From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: clear victim_secmap when section has full valid
 blocks
Date: Tue, 24 Jul 2018 17:36:44 +0800
Message-ID: <8026538e-2a8b-fad4-82b1-9bb2c04e097d@huawei.com>
References: <1532355022-163029-1-git-send-email-yunlong.song@huawei.com>
 <1532424442-9867-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532424442-9867-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/7/24 17:27, Yunlong Song wrote:
> Without this patch, f2fs only clears victim_secmap when it finds out
> that the section has no valid blocks at all, but forgets to clear the
> victim_secmap when the whole section has full valid blocks.

Look this patch again, I have a question, why bggc selected section can
get back to full state?

Thanks,

> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/segment.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index cfff7cf..0a79554 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -776,7 +776,8 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
>  		if (test_and_clear_bit(segno, dirty_i->dirty_segmap[t]))
>  			dirty_i->nr_dirty[t]--;
>  
> -		if (get_valid_blocks(sbi, segno, true) == 0)
> +		if (get_valid_blocks(sbi, segno, true) == 0 ||
> +			get_valid_blocks(sbi, segno, true) == BLKS_PER_SEC(sbi))
>  			clear_bit(GET_SEC_FROM_SEG(sbi, segno),
>  						dirty_i->victim_secmap);
>  	}
> 
