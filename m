From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 1/2] f2fs: handle failed bio allocation
Date: Thu, 20 Aug 2015 17:08:24 +0800
Message-ID: <01b801d0db27$e8b9e9d0$ba2dbd70$@samsung.com>
References: <1439593751-21879-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1439593751-21879-1-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Saturday, August 15, 2015 7:09 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 1/2] f2fs: handle failed bio allocation
> 
> As the below comment of bio_alloc_bioset, f2fs can allocate multiple bios at the
> same time. So, we can't guarantee that bio is allocated all the time.
> 
> "
>  *   When @bs is not NULL, if %__GFP_WAIT is set then bio_alloc will always be
>  *   able to allocate a bio. This is due to the mempool guarantees. To make this
>  *   work, callers must never allocate more than 1 bio at a time from this pool.
>  *   Callers that need to allocate more than 1 bio must always submit the
>  *   previously allocated bio for IO before attempting to allocate a new one.
>  *   Failure to do so can cause deadlocks under memory pressure.
> "
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c    |  3 +--
>  fs/f2fs/f2fs.h    | 15 +++++++++++++++
>  fs/f2fs/segment.c | 14 +++++++++++---
>  3 files changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index cad9ebe..726e58b 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -90,8 +90,7 @@ static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
>  {
>  	struct bio *bio;
> 
> -	/* No failure on bio allocation */
> -	bio = bio_alloc(GFP_NOIO, npages);

How about using __GFP_NOFAIL flag to avoid failing in bio_alloc instead
of adding opencode endless loop in code?

We can see the reason in this commit 	647757197cd3
("mm: clarify __GFP_NOFAIL deprecation status ")

"__GFP_NOFAIL is documented as a deprecated flag since commit
478352e789f5 ("mm: add comment about deprecation of __GFP_NOFAIL").

This has discouraged people from using it but in some cases an opencoded
endless loop around allocator has been used instead. So the allocator
is not aware of the de facto __GFP_NOFAIL allocation because this
information was not communicated properly.

Let's make clear that if the allocation context really cannot afford
failure because there is no good failure policy then using __GFP_NOFAIL
is preferable to opencoding the loop outside of the allocator."

BTW, I found that f2fs_kmem_cache_alloc also could be replaced, we could
fix them together.

Thanks,

