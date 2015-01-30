From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH 2/5] f2fs: support norecovery mount option
Date: Fri, 30 Jan 2015 13:10:15 +0800
Message-ID: <006401d03c4b$2380c600$6a825200$@samsung.com>
References: <1422401503-4769-1-git-send-email-jaegeuk@kernel.org>
 <1422401503-4769-2-git-send-email-jaegeuk@kernel.org>
 <002b01d03bba$37f763a0$a7e62ae0$@samsung.com>
 <20150129182745.GB15313@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150129182745.GB15313@jaegeuk-mac02.mot.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Friday, January 30, 2015 2:28 AM
> To: Chao Yu
> Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [PATCH 2/5] f2fs: support norecovery mount option
> 
> Hi Chao,
> 
> On Thu, Jan 29, 2015 at 07:52:56PM +0800, Chao Yu wrote:
> > Hi Jaegeuk,
> >
> > > -----Original Message-----
> > > From: linux-fsdevel-owner@vger.kernel.org [mailto:linux-fsdevel-owner@vger.kernel.org] On
> > > Behalf Of Jaegeuk Kim
> > > Sent: Wednesday, January 28, 2015 7:32 AM
> > > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > > linux-f2fs-devel@lists.sourceforge.net
> > > Cc: Jaegeuk Kim
> > > Subject: [PATCH 2/5] f2fs: support norecovery mount option
> > >
> > > This patch adds a mount option, norecovery, which is mostly same as
> > > disable_roll_forward. The only difference is that norecovery should be activated
> > > with read-only mount option.
> > >
> > > This can be used when user wants to check whether f2fs is mountable or not
> > > without any recovery process. (e.g., xfstests/200)
> > >
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > ---
> > >  fs/f2fs/super.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > index fbc7f5a..0ca1fb2 100644
> > > --- a/fs/f2fs/super.c
> > > +++ b/fs/f2fs/super.c
> > > @@ -42,6 +42,7 @@ static struct kset *f2fs_kset;
> > >  enum {
> > >  	Opt_gc_background,
> > >  	Opt_disable_roll_forward,
> > > +	Opt_norecovery,
> > >  	Opt_discard,
> > >  	Opt_noheap,
> > >  	Opt_user_xattr,
> > > @@ -62,6 +63,7 @@ enum {
> > >  static match_table_t f2fs_tokens = {
> > >  	{Opt_gc_background, "background_gc=%s"},
> > >  	{Opt_disable_roll_forward, "disable_roll_forward"},
> > > +	{Opt_norecovery, "norecovery"},
> >
> > IMO, it's better to show 'norecovery' in f2fs_show_options instead of showing
> > 'disable_roll_forward', so user will know the details of mount option as we show.
> 
> Hmm, I did think like that at the first time.
> But, as you guess, this option is totally same as ro,disable_roll_forward.
> So, I just wanted to avoid user's confusing for the behaviors of this option.

All right, I just worry about that if users could not find the key word 'norecovery' in
/etc/mtab as they think it should be there because they mount with it before. Not sure
this will happen.

> 
> >
> > >  	{Opt_discard, "discard"},
> > >  	{Opt_noheap, "no_heap"},
> > >  	{Opt_user_xattr, "user_xattr"},
> > > @@ -287,6 +289,12 @@ static int parse_options(struct super_block *sb, char *options)
> > >  		case Opt_disable_roll_forward:
> > >  			set_opt(sbi, DISABLE_ROLL_FORWARD);
> > >  			break;
> > > +		case Opt_norecovery:
> > > +			/* this option mounts f2fs with ro */
> > > +			set_opt(sbi, DISABLE_ROLL_FORWARD);
> >
> > set_opt(sbi, NORECOVERY); and check this option before recover_fsync_data()?
> >
> > It's better to add description for this "norecovery" option in Documentation.
> 
> I'll do that.

It will really help our users.
Thank you. :)

Regards,

> 
> Thanks,
> 
> >
> > Thanks,
> >
> > > +			if (!f2fs_readonly(sb))
> > > +				return -EINVAL;
> > > +			break;
> > >  		case Opt_discard:
> > >  			set_opt(sbi, DISCARD);
> > >  			break;
> > > --
> > > 2.1.1
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
