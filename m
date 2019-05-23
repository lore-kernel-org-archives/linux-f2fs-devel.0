From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/2] Revert "f2fs: don't clear
 CP_QUOTA_NEED_FSCK_FLAG"
Date: Thu, 23 May 2019 21:17:40 +0800
Message-ID: <1f370d69-cb4e-5526-cc87-e67100d91294@kernel.org>
References: <20190521180625.10562-1-jaegeuk@kernel.org>
 <8e9a4cac-c81b-11ce-0a5a-c6f5caf716c4@kernel.org>
 <20190522174448.GA81051@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190522174448.GA81051@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019-5-23 1:44, Jaegeuk Kim wrote:
> On 05/22, Chao Yu wrote:
>> On 2019-5-22 2:06, Jaegeuk Kim wrote:
>>> This reverts commit fb40d618b03978b7cc5820697894461f4a2af98b.
>>>
>>> The original patch introduced # of fsck triggers.
>>
>> How about pointing out the old issue has been fixed with below patch:
>>
>> f2fs-tools: fix to check total valid block count before block allocation
>>
>> Otherwise, user should keep kernel commit "f2fs: don't clear
>> CP_QUOTA_NEED_FSCK_FLAG".
> 
> Actually, that didn't fix my testing issue, but I found we were not using
> error control for quota_sysfile. Now I've seen no issue with the below patch.

Alright.

> 
> From e1b7de7050fd87b7c20e033b062b1cc6505679d3 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Mon, 20 May 2019 16:17:56 -0700
> Subject: [PATCH] f2fs: link f2fs quota ops for sysfile
> 
> This patch reverts:
> commit fb40d618b039 ("f2fs: don't clear CP_QUOTA_NEED_FSCK_FLAG").
> 
> We were missing error handlers used in f2fs quota ops.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Good catch!

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/checkpoint.c | 6 ++----
>  fs/f2fs/super.c      | 5 +----
>  2 files changed, 3 insertions(+), 8 deletions(-)
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
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 856f9081c599..34f2adf191ed 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3169,10 +3169,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  
>  #ifdef CONFIG_QUOTA
>  	sb->dq_op = &f2fs_quota_operations;
> -	if (f2fs_sb_has_quota_ino(sbi))
> -		sb->s_qcop = &dquot_quotactl_sysfile_ops;
> -	else
> -		sb->s_qcop = &f2fs_quotactl_ops;
> +	sb->s_qcop = &f2fs_quotactl_ops;
>  	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
>  
>  	if (f2fs_sb_has_quota_ino(sbi)) {
> 
