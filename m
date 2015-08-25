From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH 2/2] f2fs: fix to release inode correctly
Date: Tue, 25 Aug 2015 09:39:55 +0800
Message-ID: <000001d0ded7$1aa9e0a0$4ffda1e0$@samsung.com>
References: <001b01d0de51$0b369c70$21a3d550$@samsung.com>
 <20150824165423.GC2837@jaegeuk-mac02.mot-mobility.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150824165423.GC2837@jaegeuk-mac02.mot-mobility.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, August 25, 2015 12:54 AM
> To: Chao Yu
> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] f2fs: fix to release inode correctly
> 

[snip]

> > +	 * if we skip truncate_node in remove_inode_page bacause we failed
> > +	 * before, it's better to find another way to release resource of
> > +	 * this inode (e.g. valid block count, node block or nid). Here we
> > +	 * choose to add this inode to orphan list, so that we can call iput
> > +	 * for releasing in orphan recovery flow.
> > +	 *
> > +	 * Note: we should add inode to orphan list before f2fs_unlock_op()
> > +	 * so we can prevent losing this orphan when encoutering checkpoint
> > +	 * and following suddenly power-off.
> > +	 */
> > +	if (err && err != -ENOENT) {
> > +		err = acquire_orphan_inode(sbi);
> > +		if (!err)
> > +			add_orphan_inode(sbi, inode->i_ino);
> 
> 		Need this too?
> 
> 		if (err)
> 			set_sbi_flag(sbi, SBI_NEED_FSCK);

We have another chance to release inode resource in following path:
 - handle_failed_inode
  - iput
   - f2fs_evict_inode
    - f2fs_truncate
    - remove_inode_page

So I choose to set SBI_NEED_FSCK in the end of f2fs_evict_inode.

Thanks,
