From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: handle failed bio allocation
Date: Thu, 20 Aug 2015 08:57:27 -0700
Message-ID: <20150820155727.GB42028@jaegeuk-mac02.mot-mobility.com>
References: <1439593751-21879-1-git-send-email-jaegeuk@kernel.org>
	<01b801d0db27$e8b9e9d0$ba2dbd70$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZSSDg-0000fG-R9
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 20 Aug 2015 15:57:36 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZSSDf-00069U-Ig for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 20 Aug 2015 15:57:36 +0000
Content-Disposition: inline
In-Reply-To: <01b801d0db27$e8b9e9d0$ba2dbd70$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Thu, Aug 20, 2015 at 05:08:24PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Saturday, August 15, 2015 7:09 AM
> > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Cc: Jaegeuk Kim
> > Subject: [f2fs-dev] [PATCH 1/2] f2fs: handle failed bio allocation
> > 
> > As the below comment of bio_alloc_bioset, f2fs can allocate multiple bios at the
> > same time. So, we can't guarantee that bio is allocated all the time.
> > 
> > "
> >  *   When @bs is not NULL, if %__GFP_WAIT is set then bio_alloc will always be
> >  *   able to allocate a bio. This is due to the mempool guarantees. To make this
> >  *   work, callers must never allocate more than 1 bio at a time from this pool.
> >  *   Callers that need to allocate more than 1 bio must always submit the
> >  *   previously allocated bio for IO before attempting to allocate a new one.
> >  *   Failure to do so can cause deadlocks under memory pressure.
> > "
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/data.c    |  3 +--
> >  fs/f2fs/f2fs.h    | 15 +++++++++++++++
> >  fs/f2fs/segment.c | 14 +++++++++++---
> >  3 files changed, 27 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index cad9ebe..726e58b 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -90,8 +90,7 @@ static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
> >  {
> >  	struct bio *bio;
> > 
> > -	/* No failure on bio allocation */
> > -	bio = bio_alloc(GFP_NOIO, npages);
> 
> How about using __GFP_NOFAIL flag to avoid failing in bio_alloc instead
> of adding opencode endless loop in code?
> 
> We can see the reason in this commit 	647757197cd3
> ("mm: clarify __GFP_NOFAIL deprecation status ")
> 
> "__GFP_NOFAIL is documented as a deprecated flag since commit
> 478352e789f5 ("mm: add comment about deprecation of __GFP_NOFAIL").
> 
> This has discouraged people from using it but in some cases an opencoded
> endless loop around allocator has been used instead. So the allocator
> is not aware of the de facto __GFP_NOFAIL allocation because this
> information was not communicated properly.
> 
> Let's make clear that if the allocation context really cannot afford
> failure because there is no good failure policy then using __GFP_NOFAIL
> is preferable to opencoding the loop outside of the allocator."
> 
> BTW, I found that f2fs_kmem_cache_alloc also could be replaced, we could
> fix them together.

Agreed. I think that can be another patch like this.

>From 1579e0d1ada96994c4ec6619fb5b5d9386e77ab3 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 20 Aug 2015 08:51:56 -0700
Subject: [PATCH] f2fs: use __GFP_NOFAIL to avoid infinite loop

__GFP_NOFAIL can avoid retrying the whole path of kmem_cache_alloc and
bio_alloc.

Suggested-by: Chao Yu <chao2.yu@samsung.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 00591f7..c78b599 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1244,13 +1244,10 @@ static inline void *f2fs_kmem_cache_alloc(struct kmem_cache *cachep,
 						gfp_t flags)
 {
 	void *entry;
-retry:
-	entry = kmem_cache_alloc(cachep, flags);
-	if (!entry) {
-		cond_resched();
-		goto retry;
-	}
 
+	entry = kmem_cache_alloc(cachep, flags);
+	if (!entry)
+		entry = kmem_cache_alloc(cachep, flags | __GFP_NOFAIL);
 	return entry;
 }
 
@@ -1259,12 +1256,9 @@ static inline struct bio *f2fs_bio_alloc(int npages)
 	struct bio *bio;
 
 	/* No failure on bio allocation */
-retry:
 	bio = bio_alloc(GFP_NOIO, npages);
-	if (!bio) {
-		cond_resched();
-		goto retry;
-	}
+	if (!bio)
+		bio = bio_alloc(GFP_NOIO | __GFP_NOFAIL, npages);
 	return bio;
 }
 
-- 
2.1.1


------------------------------------------------------------------------------
