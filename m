From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: don't discard next free dnode page for an
 umount checkpoint
Date: Thu, 5 Feb 2015 22:22:51 -0800
Message-ID: <20150206062251.GB66378@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <008c01d03d35$62ceb7a0$286c26e0$@samsung.com>
 <20150202233734.GD34575@jaegeuk-mac02.mot.com>
 <005e01d0411c$1d2e07b0$578a1710$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <005e01d0411c$1d2e07b0$578a1710$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'Changman Lee' <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Thu, Feb 05, 2015 at 04:16:04PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Tuesday, February 03, 2015 7:38 AM
> > To: Chao Yu
> > Cc: Changman Lee; linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 2/2] f2fs: don't discard next free dnode page for an umount checkpoint
> > 
> > Hi Chao,
> > 
> > On Sat, Jan 31, 2015 at 05:06:59PM +0800, Chao Yu wrote:
> > > Previously, discard_next_dnode is added before a checkpoint to prevent that we
> > > may meet a garbage dnode page readed from next free blkaddr in recover flow.
> > >
> > > Since f2fs will skip recovery flow for a clean umount image, this condition will
> > > never happen.
> > >
> > > So it's safe for us to leave next free dnode as it is in an umount checkpoint.
> > >
> > > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > > ---
> > >  fs/f2fs/checkpoint.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > > index f7cdcad..991fd0a 100644
> > > --- a/fs/f2fs/checkpoint.c
> > > +++ b/fs/f2fs/checkpoint.c
> > > @@ -905,8 +905,12 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control
> > *cpc)
> > >  	/*
> > >  	 * This avoids to conduct wrong roll-forward operations and uses
> > >  	 * metapages, so should be called prior to sync_meta_pages below.
> > > +	 * But if we are in an umount checkpoint, we'd better skip this
> > > +	 * because we will not enter recovery flow to use the next free
> > > +	 * blkaddr when mounting it.
> > >  	 */
> > > -	discard_next_dnode(sbi, NEXT_FREE_BLKADDR(sbi, curseg));
> > > +	if (cpc->reason != CP_UMOUNT)
> > > +		discard_next_dnode(sbi, NEXT_FREE_BLKADDR(sbi, curseg));
> > 
> > The reason for discard_next_dnode is to avoid wrong execution due to old
> > mkfs.f2fs which remains gabage data.
> > It needs to do all the time.
> 
> Maybe my previously understanding is wrong.
> 
> Is this issue due to old mkfs.f2fs do not discard entire flash storage device
> when formating? Or another bug of mkfs? If so, can you please offer a fix
> commit id of mkfs?

commit ffbada4298c7aed059bb99a8d553d6dd555963c0
Author: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Date:   Mon Nov 11 13:29:11 2013 +0900

    mkfs: remove stale node blocks
        
    If the device does not support discard, we should write zero blocks
    to avoid roll-forward recovery.


Thanks,

> 
> I'm curious about how this happened. :-)
> 
> Thanks,
> > 
> > Thanks,
> > 
> > >
> > >  	/* Flush all the NAT/SIT pages */
> > >  	while (get_pages(sbi, F2FS_DIRTY_META)) {
> > > --
> > > 2.2.1
