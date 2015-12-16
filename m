From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 7/8] f2fs: introduce new option for controlling data flush
Date: Wed, 16 Dec 2015 08:54:15 -0800
Message-ID: <20151216165415.GA72223@jaegeuk.local>
References: <00fa01d136fa$7c028980$74079c80$@samsung.com>
 <20151215220238.GC66113@jaegeuk.local>
 <013501d137aa$f069ab40$d13d01c0$@samsung.com>
 <20151216024922.GA71308@jaegeuk.local>
 <013d01d137b0$9daa98f0$d8ffcad0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <013d01d137b0$9daa98f0$d8ffcad0$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, Dec 16, 2015 at 11:19:06AM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Wednesday, December 16, 2015 10:49 AM
> > To: Chao Yu
> > Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 7/8] f2fs: introduce new option for controlling data flush
> > 
> > Hi Chao,
> > 
> > On Wed, Dec 16, 2015 at 10:38:27AM +0800, Chao Yu wrote:
> > 
> > ...
> > 
> > > > > +++ b/fs/f2fs/super.c
> > > > > @@ -67,6 +67,7 @@ enum {
> > > > >  	Opt_extent_cache,
> > > > >  	Opt_noextent_cache,
> > > > >  	Opt_noinline_data,
> > > > > +	Opt_data_flush,
> > > >
> > > > Need Opt_nodata_flush too.
> > >
> > > We need this unless we set data_flush as a default option. Is that right?
> > 
> > I meant both of them.
> 
> Yeah, I know that. But the point I meant was:
> Normally we can detect user's mount option by test_opt(DATA_FLUSH), but if
> data_flush option was set as a default option in f2fs, we need to introduce
> nodata_flush to indicate whether user want to disable it or not, because we
> can't disable data_flush option by mount without it since f2fs will set
> data_flush by itself.
> 
> So it seems nodata_flush is redundant unless data_flush is set by default.
> 
> How do you think of it?

Ah, right. I simply thought the remount case, but indeed it always starts with 
default options. Default is off and turn on by user occasionally.

Thanks,

> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> > >
> > > Thanks,
> > >
> > > >
> > > > Thanks,
> > > >
> > > > >  	Opt_nodiscard,
> > > > >  	Opt_err,
> > > > >  };
> > > > > @@ -92,6 +93,7 @@ static match_table_t f2fs_tokens = {
> > > > >  	{Opt_extent_cache, "extent_cache"},
> > > > >  	{Opt_noextent_cache, "noextent_cache"},
> > > > >  	{Opt_noinline_data, "noinline_data"},
> > > > > +	{Opt_data_flush, "data_flush"},
> > > > >  	{Opt_nodiscard, "nodiscard"},
> > > > >  	{Opt_err, NULL},
> > > > >  };
> > > > > @@ -411,6 +413,9 @@ static int parse_options(struct super_block *sb, char *options)
> > > > >  		case Opt_noinline_data:
> > > > >  			clear_opt(sbi, INLINE_DATA);
> > > > >  			break;
> > > > > +		case Opt_data_flush:
> > > > > +			clear_opt(sbi, DATA_FLUSH);
> > > > > +			break;
> > > > >  		default:
> > > > >  			f2fs_msg(sb, KERN_ERR,
> > > > >  				"Unrecognized mount option \"%s\" or missing value",
> > > > > @@ -694,6 +699,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
> > > > >  		seq_puts(seq, ",extent_cache");
> > > > >  	else
> > > > >  		seq_puts(seq, ",noextent_cache");
> > > > > +	if (test_opt(sbi, DATA_FLUSH))
> > > > > +		seq_puts(seq, ",data_flush");
> > > > >  	seq_printf(seq, ",active_logs=%u", sbi->active_logs);
> > > > >
> > > > >  	return 0;
> > > > > --
> > > > > 2.6.3
> > > > >
