From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/2] Revert "f2fs: don't clear
 CP_QUOTA_NEED_FSCK_FLAG"
Date: Wed, 22 May 2019 20:29:04 +0800
Message-ID: <8e9a4cac-c81b-11ce-0a5a-c6f5caf716c4@kernel.org>
References: <20190521180625.10562-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190521180625.10562-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019-5-22 2:06, Jaegeuk Kim wrote:
> This reverts commit fb40d618b03978b7cc5820697894461f4a2af98b.
> 
> The original patch introduced # of fsck triggers.

How about pointing out the old issue has been fixed with below patch:

f2fs-tools: fix to check total valid block count before block allocation

Otherwise, user should keep kernel commit "f2fs: don't clear
CP_QUOTA_NEED_FSCK_FLAG".

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index d0539ddad6e2..89825261d474 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1317,10 +1317,8 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  
>  	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
>  		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> -	/*
> -	 * TODO: we count on fsck.f2fs to clear this flag until we figure out
> -	 * missing cases which clear it incorrectly.
> -	 */
> +	else
> +		__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
>  
>  	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
>  		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> 
