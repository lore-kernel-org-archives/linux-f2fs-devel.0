From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/4] f2fs: avoid very large discard command
Date: Thu, 23 Feb 2017 10:41:27 -0800
Message-ID: <20170223184127.GB2026@jaegeuk.local>
References: <20170223042850.43456-1-jaegeuk@kernel.org>
	<20170223101627.GA31074@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cgyKf-00081W-4O
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 18:41:37 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cgyKd-0004z9-4Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 18:41:37 +0000
Content-Disposition: inline
In-Reply-To: <20170223101627.GA31074@infradead.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 02/23, Christoph Hellwig wrote:
> On Wed, Feb 22, 2017 at 08:28:47PM -0800, Jaegeuk Kim wrote:
> > This patch adds MAX_DISCARD_BLOCKS() to avoid issuing too much large single
> > discard command.
> 
> Needs an explanation in the code on why this number was chosen.

No need to add a trivial comment, since it's the section size which we can
easily translate it.

> In doubt I suspect it should be a quirk in the driver for the device,
> and not something decided by the fs.

The block allocator checks all the issued bios whether any of them contains
the newly allocated address or not. If one large discard command was issued,
it needs to wait for its completion, even if we want to allocate part of its
address space.

In addition, HM-SMR is required to issue discard/reset in a unit of section
size.

Thanks,

> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/f2fs.h    | 3 ++-
> >  fs/f2fs/segment.c | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index d076b94530bc..5f3fe97df055 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -133,7 +133,8 @@ enum {
> >  		(SM_I(sbi)->trim_sections * (sbi)->segs_per_sec)
> >  #define BATCHED_TRIM_BLOCKS(sbi)	\
> >  		(BATCHED_TRIM_SEGMENTS(sbi) << (sbi)->log_blocks_per_seg)
> > -
> > +#define MAX_DISCARD_BLOCKS(sbi)						\
> > +		((1 << (sbi)->log_blocks_per_seg) * (sbi)->segs_per_sec)
> >  #define DISCARD_ISSUE_RATE	8
> >  #define DEF_CP_INTERVAL			60	/* 60 secs */
> >  #define DEF_IDLE_INTERVAL		5	/* 5 secs */
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index fe434cd872b4..567019940e9b 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -886,7 +886,8 @@ static void __add_discard_entry(struct f2fs_sb_info *sbi,
> >  	if (!list_empty(head)) {
> >  		last = list_last_entry(head, struct discard_entry, list);
> >  		if (START_BLOCK(sbi, cpc->trim_start) + start ==
> > -						last->blkaddr + last->len) {
> > +				last->blkaddr + last->len &&
> > +				last->len < MAX_DISCARD_BLOCKS(sbi)) {
> >  			last->len += end - start;
> >  			goto done;
> >  		}
> > -- 
> > 2.11.0
> > 
> ---end quoted text---

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
