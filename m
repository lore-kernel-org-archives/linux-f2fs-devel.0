From: Sheng Yong <shengyong1@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: check memory boundary by insane namelen
Date: Fri, 23 Nov 2018 20:11:15 +0800
Message-ID: <3d213d40-a4b0-6e60-87b2-81e66866ac4c@huawei.com>
References: <20181115075040.83500-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115075040.83500-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: "gongchen (E)" <gongchen4@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi, Jaegeuk and Chao,

On 2018/11/15 15:50, Jaegeuk Kim wrote:
> If namelen is corrupted to have very long value, fill_dentries can copy
> wrong memory area.
> 
Is there any scenario that could hit this corruption? Or this is triggered
by fuzzing injection?

thanks,
Sheng Yong

> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/dir.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index bacc667950b6..c0c845da12fa 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -808,6 +808,17 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
>   		de_name.name = d->filename[bit_pos];
>   		de_name.len = le16_to_cpu(de->name_len);
>   
> +		/* check memory boundary before moving forward */
> +		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
> +		if (unlikely(bit_pos > d->max)) {
> +			f2fs_msg(sbi->sb, KERN_WARNING,
> +				"%s: corrupted namelen=%d, run fsck to fix.",
> +				__func__, le16_to_cpu(de->name_len));
> +			set_sbi_flag(sbi, SBI_NEED_FSCK);
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
>   		if (f2fs_encrypted_inode(d->inode)) {
>   			int save_len = fstr->len;
>   
> @@ -830,7 +841,6 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
>   		if (readdir_ra)
>   			f2fs_ra_node_page(sbi, le32_to_cpu(de->ino));
>   
> -		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
>   		ctx->pos = start_pos + bit_pos;
>   	}
>   out:
> 
