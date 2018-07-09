From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: do checkpoint in kill_sb
Date: Mon, 9 Jul 2018 13:36:24 -0700
Message-ID: <20180709203624.GA24534@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180707012020.4708-1-jaegeuk@kernel.org>
 <0cb1e0fd-1fb4-ba69-6c70-e05e991a243a@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0cb1e0fd-1fb4-ba69-6c70-e05e991a243a@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 07/09, Chao Yu wrote:
> On 2018/7/7 9:20, Jaegeuk Kim wrote:
> > When unmounting f2fs in force mode, we can get it stuck by io_schedule()
> 
> force mode means force shutdown?

Yes.

> 
> > by some pending IOs in meta_inode.
> > 
> > io_schedule+0xd/0x30
> > wait_on_page_bit_common+0xc6/0x130
> 
> Looks like a deadlock here? Does this mean we forget to submit cached bio in
> somewhere?

I'm hitting this randomly, when running all the testcases in xfstests.
I can't find the missing flow, and only get this during kill_sb.

> 
> Thanks,
> 
> > __filemap_fdatawait_range+0xbd/0x100
> > filemap_fdatawait_keep_errors+0x15/0x40
> > sync_inodes_sb+0x1cf/0x240
> > sync_filesystem+0x52/0x90
> > generic_shutdown_super+0x1d/0x110
> > ceph_kill_sb+0x28/0x80 [ceph]
> > deactivate_locked_super+0x35/0x60
> > cleanup_mnt+0x36/0x70
> > task_work_run+0x79/0xa0
> > exit_to_usermode_loop+0x62/0x70
> > do_syscall_64+0xdb/0xf0
> > entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 0xffffffffffffffff
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/super.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 3995e926ba3a..1dc6809fac38 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -3089,9 +3089,19 @@ static struct dentry *f2fs_mount(struct file_system_type *fs_type, int flags,
> >  static void kill_f2fs_super(struct super_block *sb)
> >  {
> >  	if (sb->s_root) {
> > -		set_sbi_flag(F2FS_SB(sb), SBI_IS_CLOSE);
> > -		f2fs_stop_gc_thread(F2FS_SB(sb));
> > -		f2fs_stop_discard_thread(F2FS_SB(sb));
> > +		struct f2fs_sb_info *sbi = F2FS_SB(sb);
> > +
> > +		set_sbi_flag(sbi, SBI_IS_CLOSE);
> > +		f2fs_stop_gc_thread(sbi);
> > +		f2fs_stop_discard_thread(sbi);
> > +
> > +		if (is_sbi_flag_set(sbi, SBI_IS_DIRTY) ||
> > +				!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
> > +			struct cp_control cpc = {
> > +				.reason = CP_UMOUNT,
> > +			};
> > +			f2fs_write_checkpoint(sbi, &cpc);
> > +		}
> >  	}
> >  	kill_block_super(sb);
> >  }
> > 
