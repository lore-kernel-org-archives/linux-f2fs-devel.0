From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix double count on issued discard
 commands
Date: Tue, 12 Sep 2017 09:53:19 +0800
Message-ID: <b6550c76-448a-fa48-eef8-3abcc2835b30@huawei.com>
References: <20170911033845.53701-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170911033845.53701-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/9/11 11:38, Jaegeuk Kim wrote:
> If issue_cond is true, it does double count for # of issued commands.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> ---
>  fs/f2fs/segment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 7fd742f747ce..25196ff5d587 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1087,7 +1087,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
>  				issued++;
>  				__submit_discard_cmd(sbi, dc);
>  			}
> -			if (issue_cond && iter++ > DISCARD_ISSUE_RATE)
> +			if (issue_cond && iter > DISCARD_ISSUE_RATE)
>  				goto out;
>  		}
>  		if (list_empty(pend_list) && dcc->pend_list_tag[i] & P_TRIM)
> 
