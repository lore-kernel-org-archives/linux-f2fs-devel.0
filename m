From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix ref of discard command
Date: Mon, 12 Jun 2017 19:17:38 +0800
Message-ID: <54b5aaad-1674-8d76-c489-d5eee6ef7f26@huawei.com>
References: <20170612030449.79290-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170612030449.79290-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2017/6/12 11:04, Jaegeuk Kim wrote:
> This patch resolves kernel panic for xfstests/081, caused by recent f2fs_bug_on
> 
>   f2fs: add f2fs_bug_on in __remove_discard_cmd
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/segment.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 86a0c1095939..a6d77388a806 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1025,6 +1025,8 @@ static void __wait_discard_cmd(struct f2fs_sb_info *sbi, bool wait_cond)
>  	list_for_each_entry_safe(dc, tmp, wait_list, list) {
>  		if (!wait_cond || (dc->state == D_DONE && !dc->ref)) {
>  			wait_for_completion_io(&dc->wait);
> +			if (dc->state == D_DONE && dc->ref)
> +				dc->ref--;

Should set dc->ref to 0 to avoid panic once we add other referrers?

Thanks,

>  			__remove_discard_cmd(sbi, dc);
>  		} else {
>  			dc->ref++;
> 
