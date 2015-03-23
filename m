From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: Re: [PATCH v2 1/2] f2fs: enable inline data by default
Date: Mon, 23 Mar 2015 16:22:43 +0800
Message-ID: <20150323082243.GA3168@kernel>
References: <1427067840-20610-1-git-send-email-wanpeng.li@linux.intel.com>
 <000c01d0653a$b6becad0$243c6070$@samsung.com>
 <20150323071503.GA2674@kernel>
 <000d01d06544$8f5554a0$adfffde0$@samsung.com>
Reply-To: Wanpeng Li <wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <000d01d06544$8f5554a0$adfffde0$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'Changman Lee' <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 'Wanpeng Li' <wanpeng.li@linux.intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Mon, Mar 23, 2015 at 04:36:18PM +0800, Chao Yu wrote:
>> >like F2FS_MOUNT_BG_GC.
>> >
>> >e.g.
>> >parse_options:
>> >	case Opt_noinline_data:
>> >		clear_opt(sbi, INLINE_DATA);
>> >		break;
>> >
>> >f2fs_show_options:
>> >	if (test_opt(sbi, INLINE_DATA))
>> >		seq_puts(seq, ",inline_data");
>> >	else
>> >		seq_puts(seq, ",noinline_data");
>> >
>> >So we can avoid to show both options "inline_data,noinline_data" in ->show_options
>
>Note "show content generated ->show_options", not content in /etc/mtab.
>
>> >if we mount with noinline_data, since this will make our user confused.
>> 
>> I didn't see "inline_data, noinline_data" w/ noinline_data mount option, just
>> "rw,noinline_data" dump out.
>
>Try 'cat /proc/mounts'?

Ah, I just try mount command, and "inline_data, noinline_data" dump out
when cat /proc/mounts, I will fix it soon. 

Regards,
Wanpeng Li

>
>Thanks,
>
>> 
>> Ping Jaegeuk!
>> 
>> Regards,
>> Wanpeng Li
>> 
>> >
>> >How do you think?
>> >
>> >Thanks,
>> >
>> >>
>> >>  #define clear_opt(sbi, option)	(sbi->mount_opt.opt &= ~F2FS_MOUNT_##option)
>> >>  #define set_opt(sbi, option)	(sbi->mount_opt.opt |= F2FS_MOUNT_##option)
>> >> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
>> >> index d3e0599..0363b57 100644
>> >> --- a/fs/f2fs/inline.c
>> >> +++ b/fs/f2fs/inline.c
>> >> @@ -15,7 +15,7 @@
>> >>
>> >>  bool f2fs_may_inline(struct inode *inode)
>> >>  {
>> >> -	if (!test_opt(F2FS_I_SB(inode), INLINE_DATA))
>> >> +	if (!test_opt(F2FS_I_SB(inode), NOINLINE_DATA))
>> >>  		return false;
>> >>
>> >>  	if (f2fs_is_atomic_file(inode))
>> >> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> >> index fc6857f..7b17795 100644
>> >> --- a/fs/f2fs/super.c
>> >> +++ b/fs/f2fs/super.c
>> >> @@ -58,6 +58,7 @@ enum {
>> >>  	Opt_nobarrier,
>> >>  	Opt_fastboot,
>> >>  	Opt_extent_cache,
>> >> +	Opt_noinline_data,
>> >>  	Opt_err,
>> >>  };
>> >>
>> >> @@ -80,6 +81,7 @@ static match_table_t f2fs_tokens = {
>> >>  	{Opt_nobarrier, "nobarrier"},
>> >>  	{Opt_fastboot, "fastboot"},
>> >>  	{Opt_extent_cache, "extent_cache"},
>> >> +	{Opt_noinline_data, "noinline_data"},
>> >>  	{Opt_err, NULL},
>> >>  };
>> >>
>> >> @@ -372,6 +374,9 @@ static int parse_options(struct super_block *sb, char *options)
>> >>  		case Opt_extent_cache:
>> >>  			set_opt(sbi, EXTENT_CACHE);
>> >>  			break;
>> >> +		case Opt_noinline_data:
>> >> +			set_opt(sbi, NOINLINE_DATA);
>> >> +			break;
>> >>  		default:
>> >>  			f2fs_msg(sb, KERN_ERR,
>> >>  				"Unrecognized mount option \"%s\" or missing value",
>> >> @@ -606,6 +611,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>> >>  		seq_puts(seq, ",fastboot");
>> >>  	if (test_opt(sbi, EXTENT_CACHE))
>> >>  		seq_puts(seq, ",extent_cache");
>> >> +	if (test_opt(sbi, NOINLINE_DATA))
>> >> +		seq_puts(seq, ",noinline_data");
>> >>  	seq_printf(seq, ",active_logs=%u", sbi->active_logs);
>> >>
>> >>  	return 0;
>> >> @@ -991,6 +998,7 @@ try_onemore:
>> >>  	sbi->active_logs = NR_CURSEG_TYPE;
>> >>
>> >>  	set_opt(sbi, BG_GC);
>> >> +	set_opt(sbi, INLINE_DATA);
>> >>
>> >>  #ifdef CONFIG_F2FS_FS_XATTR
>> >>  	set_opt(sbi, XATTR_USER);
>> >> --
>> >> 1.9.1
