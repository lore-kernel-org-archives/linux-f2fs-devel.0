From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: no need to create issue_discard_thread if it exists
Date: Thu, 6 Jul 2017 21:16:19 +0800
Message-ID: <c76a5045-078b-1018-23f8-ccfaefa6f2b4@kernel.org>
References: <1499339134-104480-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499339134-104480-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, sylinux@163.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Yunlong,

It looks there is no way to create discard thread redundantly,
so here we don't need to check this?

Thanks,

On 2017/7/6 19:05, Yunlong Song wrote:
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/segment.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 4c246e3..b48d004 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1417,6 +1417,8 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>  
>  	if (SM_I(sbi)->dcc_info) {
>  		dcc = SM_I(sbi)->dcc_info;
> +		if (dcc->f2fs_issue_discard)
> +			return err;
>  		goto init_thread;
>  	}
>  
> 
