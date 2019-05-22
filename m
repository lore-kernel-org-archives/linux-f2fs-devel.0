From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: allow ssr block allocation during
 checkpoint=disable period
Date: Wed, 22 May 2019 20:32:54 +0800
Message-ID: <add17fa8-f381-844b-abf2-17182a00232a@kernel.org>
References: <20190521180625.10562-1-jaegeuk@kernel.org>
 <20190521180625.10562-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190521180625.10562-2-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019-5-22 2:06, Jaegeuk Kim wrote:
> This patch allows to use ssr during checkpoint is disabled.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/gc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 963fb4571fd9..1e029da26053 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -387,7 +387,8 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>  			goto next;
>  		/* Don't touch checkpointed data */
>  		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
> -					get_ckpt_valid_blocks(sbi, segno)))
> +					get_ckpt_valid_blocks(sbi, segno) &&
> +					p.alloc_mode != SSR))

p.alloc_mode == LFS will be more straightforward. :)

Anyway,

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

>  			goto next;
>  		if (gc_type == BG_GC && test_bit(secno, dirty_i->victim_secmap))
>  			goto next;
> 
