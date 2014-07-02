From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: check bdi->dirty_exceeded when trying to skip data
 writes
Date: Wed, 2 Jul 2014 02:31:26 -0700
Message-ID: <20140702093126.GA25404@jmac.local>
References: <1403956718-17575-1-git-send-email-jaegeuk@kernel.org>
 <20140701225420.6cc94fb5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140701225420.6cc94fb5.akpm@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, Jul 01, 2014 at 10:54:20PM -0700, Andrew Morton wrote:
> On Sat, 28 Jun 2014 20:58:38 +0900 Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> 
> > If we don't check the current backing device status, balance_dirty_pages can
> > fall into infinite pausing routine.
> > 
> > This can be occurred when a lot of directories make a small number of dirty
> > dentry pages including files.
> > 
> > ...
> >
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -43,6 +43,8 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
> >  		mem_size = (nm_i->nat_cnt * sizeof(struct nat_entry)) >> 12;
> >  		res = mem_size < ((val.totalram * nm_i->ram_thresh / 100) >> 2);
> >  	} else if (type == DIRTY_DENTS) {
> > +		if (sbi->sb->s_bdi->dirty_exceeded)
> > +			return false;
> >  		mem_size = get_pages(sbi, F2FS_DIRTY_DENTS);
> >  		res = mem_size < ((val.totalram * nm_i->ram_thresh / 100) >> 1);
> >  	}
> 
> err, filesystems should not be playing around with this.
> 
> Perhaps VFS changes are needed.  Please tell us much much more about
> what is going on here.

The f2fs has a feature which throttles IOs to merge bios in the fs level as much
as possible by bypassing writepages in some cases.

One of the cases is related to the dentry pages.
If a direcotry has a small number of dirty dentry pages and there is an amount
of free memory, f2fs skips writepages.

The code in f2fs_write_data_pages is:

	if (S_ISDIR(inode->i_mode) && wbc->sync_mode == WB_SYNC_NONE &&
			get_dirty_dents(inode) < nr_pages_to_skip(sbi, DATA) &&
			available_free_memory(sbi, DIRTY_DENTS))
		goto skip_write;

However, if many many directories have been created and all of each directories
has a small number of dirty pages in a very short time, it makes an effect on
balance_dirty_pages.

In such the case, balance_dirty_pages waits for decreasing dirty pages but f2fs
starts to skip flushing the dirty pages continuously.
So, this patch adds a condition to avoid that behavior by checking bdi's
dirty_exceeded.

So, any recommendation instead of this kinda workaround?

IMHO, how about setting wbc->sync_mode with WB_SYNC_ALL when detecting the case?

Thanks,

-- 
Jaegeuk Kim
