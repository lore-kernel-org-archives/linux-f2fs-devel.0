From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: turn quota off when error occurs
Date: Sun, 22 Oct 2017 23:16:17 +0800
Message-ID: <d150c646-64fd-84a0-4fc7-837b9efcb85e@kernel.org>
References: <20171020155337.5354-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171020155337.5354-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/10/20 23:53, Jaegeuk Kim wrote:
> Before changing readonly, it needs to turn quota off.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 201608281681..ff74665d7f2d 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -29,6 +29,7 @@ struct kmem_cache *inode_entry_slab;
>  void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
>  {
>  	set_ckpt_flags(sbi, CP_ERROR_FLAG);
> +	f2fs_quota_off_umount(sb);
>  	sbi->sb->s_flags |= MS_RDONLY;
>  	if (!end_io)

Oh, f2fs_stop_checkpoint can be called from end_io, how about adding
f2fs_quota_off_umount here?

Thanks,

>  		f2fs_flush_merged_writes(sbi);
> 
