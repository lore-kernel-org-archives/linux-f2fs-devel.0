From: Viacheslav Dubeyko <slava@dubeyko.com>
Subject: Re: [PATCH] f2fs: introduce on-disk layout version checking
 functionality
Date: Tue, 24 May 2016 18:05:23 -0700
Message-ID: <1464138323.2680.27.camel@slavad-ubuntu-14.04>
References: <1463679966.3573.4.camel@slavad-ubuntu-14.04>
	 <20160523211357.GA17297@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160523211357.GA17297@jaegeuk.gateway>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Vyacheslav.Dubeyko@hgst.com, Cyril.Guyot@hgst.com, Adam.Manzanares@hgst.com, Damien.LeMoal@hgst.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On Mon, 2016-05-23 at 14:13 -0700, Jaegeuk Kim wrote:
> Hi Slava,
> 
> On Thu, May 19, 2016 at 10:46:06AM -0700, Viacheslav Dubeyko wrote:
> ...
> >  
> > +#ifdef CONFIG_F2FS_16TB_VOLUME_SUPPORT
> > +#define F2FS_MAX_SUPP_MAJOR_VERSION		(2)
> > +#define F2FS_MIN_16TB_VOLUME_SUPPORT_VERSION	(2)
> > +#else
> > +#define F2FS_MAX_SUPP_MAJOR_VERSION		(1)
> > +#endif
> > +
> ...
> >  
> > +static int f2fs_check_version_and_features(struct super_block *sb,
> > +					   struct f2fs_super_block *raw_super)
> > +{
> > +	u16 major_ver = le16_to_cpu(raw_super->major_ver);
> > +	u32 feature = le32_to_cpu(raw_super->feature);
> > +
> > +	if (major_ver > F2FS_MAX_SUPP_MAJOR_VERSION) {
> 
> This means, for example, f2fs driver in v4.8 will deny to mount a partition
> formatted by mkfs.f2fs v3.x, which doesn't make sense, IIUC.
> 

I didn't catch the point. Maybe, I've missed something but, as far as I
can judge, f2fs driver v.4.8 will mount as old version of on-disk layout
as the new one. But right now it doesn't make sense to discuss this
topic because we haven't consent about ideology of this patch.

> As Christoph mentioned, how about checking the feature only like this?
> 
> 1. if the feature is ON,
>  - go 64 bits   , when compiled w/  F2FS_MIN_16TB_VOLUME_SUPPORT
>  - fail to mount, when compiled w/o F2FS_MIN_16TB_VOLUME_SUPPORT
> 
> 2. if the feature is OFF,
>  - fail to mount, when compiled w/  F2FS_MIN_16TB_VOLUME_SUPPORT
>  - go 32 bits   , when compiled w/o F2FS_MIN_16TB_VOLUME_SUPPORT
> 
> Thoughts?
> 

So, my logic is simple. We are trying to modify the on-disk layout. As a
result, we need to check the on-disk layout version, from my viewpoint.
And this modification is not "feature" itself but simple bug fix. And I
believe that "major_ver", "minor_ver" in F2FS superblock is the on-disk
layout version.

What do you think? Do you still believe that it should be a feature
flag?

Thanks,
Vyacheslav Dubeyko.
