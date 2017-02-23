From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/4] f2fs: avoid very large discard command
Date: Thu, 23 Feb 2017 02:16:27 -0800
Message-ID: <20170223101627.GA31074@infradead.org>
References: <20170223042850.43456-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-block-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170223042850.43456-1-jaegeuk@kernel.org>
Sender: linux-block-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, Feb 22, 2017 at 08:28:47PM -0800, Jaegeuk Kim wrote:
> This patch adds MAX_DISCARD_BLOCKS() to avoid issuing too much large single
> discard command.

Needs an explanation in the code on why this number was chosen.
In doubt I suspect it should be a quirk in the driver for the device,
and not something decided by the fs.

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/f2fs.h    | 3 ++-
>  fs/f2fs/segment.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index d076b94530bc..5f3fe97df055 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -133,7 +133,8 @@ enum {
>  		(SM_I(sbi)->trim_sections * (sbi)->segs_per_sec)
>  #define BATCHED_TRIM_BLOCKS(sbi)	\
>  		(BATCHED_TRIM_SEGMENTS(sbi) << (sbi)->log_blocks_per_seg)
> -
> +#define MAX_DISCARD_BLOCKS(sbi)						\
> +		((1 << (sbi)->log_blocks_per_seg) * (sbi)->segs_per_sec)
>  #define DISCARD_ISSUE_RATE	8
>  #define DEF_CP_INTERVAL			60	/* 60 secs */
>  #define DEF_IDLE_INTERVAL		5	/* 5 secs */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index fe434cd872b4..567019940e9b 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -886,7 +886,8 @@ static void __add_discard_entry(struct f2fs_sb_info *sbi,
>  	if (!list_empty(head)) {
>  		last = list_last_entry(head, struct discard_entry, list);
>  		if (START_BLOCK(sbi, cpc->trim_start) + start ==
> -						last->blkaddr + last->len) {
> +				last->blkaddr + last->len &&
> +				last->len < MAX_DISCARD_BLOCKS(sbi)) {
>  			last->len += end - start;
>  			goto done;
>  		}
> -- 
> 2.11.0
> 
---end quoted text---
