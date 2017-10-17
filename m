From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 1/1] f2fs: simplify the calculation of
 fggc_threshold
Date: Tue, 17 Oct 2017 22:33:08 +0800
Message-ID: <a1c60acf-1a71-9acd-279b-341440d14981@kernel.org>
References: <1508244140-8831-1-git-send-email-sunqiuyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1e4Svv-0002y7-QH
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Oct 2017 14:33:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e4Svu-0003mK-Vq
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Oct 2017 14:33:27 +0000
In-Reply-To: <1508244140-8831-1-git-send-email-sunqiuyang@huawei.com>
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
To: sunqiuyang <sunqiuyang@huawei.com>, linux-f2fs-devel@lists.sourceforge.net

On 2017/10/17 20:42, sunqiuyang wrote:
> From: Qiuyang Sun <sunqiuyang@huawei.com>
> 
> Do not need to convert segment counts to blocks for this calculation.
> 
> Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com> 

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/gc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 197ebf4..9df8cae 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1073,16 +1073,16 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>  
>  void build_gc_manager(struct f2fs_sb_info *sbi)
>  {
> -	u64 main_count, resv_count, ovp_count;
> +	unsigned int main_count, resv_count, ovp_count;
>  
>  	DIRTY_I(sbi)->v_ops = &default_v_ops;
>  
>  	/* threshold of # of valid blocks in a section for victims of FG_GC */
> -	main_count = SM_I(sbi)->main_segments << sbi->log_blocks_per_seg;
> -	resv_count = SM_I(sbi)->reserved_segments << sbi->log_blocks_per_seg;
> -	ovp_count = SM_I(sbi)->ovp_segments << sbi->log_blocks_per_seg;
> +	main_count = SM_I(sbi)->main_segments;
> +	resv_count = SM_I(sbi)->reserved_segments;
> +	ovp_count = SM_I(sbi)->ovp_segments;
>  
> -	sbi->fggc_threshold = div64_u64((main_count - ovp_count) *
> +	sbi->fggc_threshold = div_u64((u64)(main_count - ovp_count) *
>  				BLKS_PER_SEC(sbi), (main_count - resv_count));
>  
>  	/* give warm/cold data area from slower device */
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
