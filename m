From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs-tools: fix is_set_ckpt_flags for correct bool value
Date: Tue, 12 Sep 2017 09:11:44 +0800
Message-ID: <57e1432e-63bb-9190-d31e-6a425610d813@huawei.com>
References: <1505042129-41945-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1505042129-41945-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/9/10 19:15, Yunlong Song wrote:
> If flag bit to check is in 0xFFFFFF00, then the return value will be false,
> this is not correct, so fix it.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> ---
>  fsck/f2fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fsck/f2fs.h b/fsck/f2fs.h
> index 871cffc..de03512 100644
> --- a/fsck/f2fs.h
> +++ b/fsck/f2fs.h
> @@ -276,7 +276,7 @@ static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
>  static inline bool is_set_ckpt_flags(struct f2fs_checkpoint *cp, unsigned int f)
>  {
>  	unsigned int ckpt_flags = le32_to_cpu(cp->ckpt_flags);
> -	return ckpt_flags & f;
> +	return ckpt_flags & f ? 1 : 0;
>  }
>  
>  static inline block_t __start_cp_addr(struct f2fs_sb_info *sbi)
> 
