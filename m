From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: avoid redundant f2fs_flush after remount
Date: Sat, 24 Jun 2017 22:59:44 +0800
Message-ID: <53263f00-2bed-b547-a2b2-ceb9f9aa94ec@kernel.org>
References: <1498291039-142563-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498291039-142563-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, sylinux@163.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/6/24 15:57, Yunlong Song wrote:
> create_flush_cmd_control will create redundant issue_flush_thread after each
> remount with flush_merge option.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/segment.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index a6d7738..57f9edc 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -555,6 +555,8 @@ int create_flush_cmd_control(struct f2fs_sb_info *sbi)
>  
>  	if (SM_I(sbi)->fcc_info) {
>  		fcc = SM_I(sbi)->fcc_info;
> +		if (fcc->f2fs_issue_flush)
> +			return err;
>  		goto init_thread;
>  	}
>  
> 
