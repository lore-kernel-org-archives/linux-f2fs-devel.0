From: Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH] f2fs: data: fix warning Using plain integer as NULL
 pointer
Date: Sun, 7 Apr 2019 00:36:38 +0530
Message-ID: <22201e87-47ed-d660-ca15-33567daab355@codeaurora.org>
References: <20190406105936.GA30585@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190406105936.GA30585@hari-Inspiron-1545>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hariprasad Kelam <hariprasad.kelam@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net


On 4/6/2019 4:29 PM, Hariprasad Kelam wrote:
> changed passing function argument "0 to NULL" to fix below sparse
> warning
>
> fs/f2fs/data.c:426:47: warning: Using plain integer as NULL pointer
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   fs/f2fs/data.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 97279441..15a2381 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -423,7 +423,7 @@ static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
>   
>   void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type)
>   {
> -	__submit_merged_write_cond(sbi, NULL, 0, 0, type, true);
> +	__submit_merged_write_cond(sbi, NULL, NULL, 0, type, true);
>   }
>   
>   void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
