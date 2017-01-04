From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 01/10] f2fs: reassign new segment for mode=lfs
Date: Wed, 4 Jan 2017 11:24:36 +0800
Message-ID: <702b01ba-5fcb-01a2-0bad-65ea9005b834@huawei.com>
References: <20161230185117.3832-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20161230185117.3832-1-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2016/12/31 2:51, Jaegeuk Kim wrote:
> Otherwise we can remain wrong curseg->next_blkoff, resulting in fsck failure.

Could you explain more about this case?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/segment.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index be9e4d244d75..4e5ffe1d97e4 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1428,9 +1428,6 @@ void allocate_new_segments(struct f2fs_sb_info *sbi)
>  	unsigned int old_segno;
>  	int i;
>  
> -	if (test_opt(sbi, LFS))
> -		return;
> -
>  	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
>  		curseg = CURSEG_I(sbi, i);
>  		old_segno = curseg->segno;
> 

