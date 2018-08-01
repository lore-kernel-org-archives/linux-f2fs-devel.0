From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: check total CP pack block count
 correctly
Date: Wed, 1 Aug 2018 14:56:06 +0800
Message-ID: <b236d4bc-90ae-95bd-e832-0789f12d6eae@huawei.com>
References: <20180801034622.162122-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fkl3Y-0007f8-Lv
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Aug 2018 06:56:24 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fkl3W-004RuL-7p
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Aug 2018 06:56:24 +0000
In-Reply-To: <20180801034622.162122-1-shengyong1@huawei.com>
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
Cc: miaoxie@huawei.com, tony.zhangxiaobo@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Hi Sheng,

On 2018/8/1 11:46, Sheng Yong wrote:
> Fixes: 652d19558a347 ('f2fs: fix to do sanity check with block address in main area')
> Reported-by: Zhang Xiaobo <tony.zhangxiaobo@huawei.com>
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>

That's my bad, and thanks for the fix.

Do you mind merge this into buggy patch, since the patch has not been upstreamed
yet.

Thanks,

> ---
>  fs/f2fs/checkpoint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 3587aa53dc90..c32ee10a1384 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -809,7 +809,7 @@ static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
>  		goto invalid_cp1;
>  
>  	if (le32_to_cpu(cp_block->cp_pack_total_block_count) >
> -					sbi->log_blocks_per_seg) {
> +					sbi->blocks_per_seg - 1) {
>  		f2fs_msg(sbi->sb, KERN_WARNING,
>  			"invalid cp_pack_total_block_count:%u",
>  			le32_to_cpu(cp_block->cp_pack_total_block_count));
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
