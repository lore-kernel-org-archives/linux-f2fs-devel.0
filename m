From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: allow zeroed name length during
 find_dentry
Date: Thu, 16 Jul 2015 18:57:43 -0700
Message-ID: <20150717015623.GA94233@jaegeuk-mac02.mot.com>
References: <1436999892-86682-1-git-send-email-jaegeuk@kernel.org>
 <1436999892-86682-3-git-send-email-jaegeuk@kernel.org>
 <018b01d0bfae$ce294410$6a7bcc30$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <018b01d0bfae$ce294410$6a7bcc30$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Thu, Jul 16, 2015 at 06:03:46PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Thursday, July 16, 2015 6:38 AM
> > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Cc: Jaegeuk Kim
> > Subject: [f2fs-dev] [PATCH 3/3] f2fs: allow zeroed name length during find_dentry
> > 
> > Since find_dentry doesn't lock its dentry page, it can traverse intermediate
> > bit positions consisting of a big dentry.
> > For these bit positions, this patch fills the intermediate name length fields
> > as zeros and skips them during look-up.
> 
> I didn't get it, AFAIK, dentry page will be accessed under protection of
> i_mutex, if our inode operation has no bug, why this zeroed name_len can
> exist?

Indeed. I've checked that again, and i_mutex covers this.
I'll drop this patch, and let me keep an eye on any further bug report about
this. :)

Thanks,

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/dir.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> > index a34ebd8..71195f5 100644
> > --- a/fs/f2fs/dir.c
> > +++ b/fs/f2fs/dir.c
> > @@ -141,11 +141,15 @@ struct f2fs_dir_entry *find_target_dentry(struct f2fs_filename *fname,
> >  			*max_slots = max_len;
> >  		max_len = 0;
> > 
> > -		/* remain bug on condition */
> > -		if (unlikely(!de->name_len))
> > -			d->max = -1;
> > -
> > -		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
> > +		/*
> > +		 * While a large dentry is adding, it can traverse its valid bit
> > +		 * positions, since find_entry does not lock its dentry page.
> > +		 * In that case, let's skip the bit position.
> > +		 */
> > +		if (de_name.len == 0)
> > +			bit_pos++;
> > +		else
> > +			bit_pos += GET_DENTRY_SLOTS(de_name.len);
> >  	}
> > 
> >  	de = NULL;
> > @@ -505,8 +509,12 @@ void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr
> > *d,
> >  	memcpy(d->filename[bit_pos], name->name, name->len);
> >  	de->ino = cpu_to_le32(ino);
> >  	set_de_type(de, mode);
> > -	for (i = 0; i < slots; i++)
> > +	for (i = 0; i < slots; i++) {
> > +		/* fill zeros for intermediate name_len slots */
> > +		if (i >= 1)
> > +			d->dentry[bit_pos + i].name_len = 0;
> >  		test_and_set_bit_le(bit_pos + i, (void *)d->bitmap);
> > +	}
> >  }
> > 
> >  /*
> > --
> > 2.1.1
> > 
> > 
> > ------------------------------------------------------------------------------
> > Don't Limit Your Business. Reach for the Cloud.
> > GigeNET's Cloud Solutions provide you with the tools and support that
> > you need to offload your IT needs and focus on growing your business.
> > Configured For All Businesses. Start Your Cloud Today.
> > https://www.gigenetcloud.com/
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
