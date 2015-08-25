From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: fix to release inode correctly
Date: Tue, 25 Aug 2015 15:17:36 -0700
Message-ID: <20150825221736.GA12070@jaegeuk-mac02.mot.com>
References: <001b01d0de51$0b369c70$21a3d550$@samsung.com>
	<20150824165423.GC2837@jaegeuk-mac02.mot-mobility.com>
	<000001d0ded7$1aa9e0a0$4ffda1e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZUMXL-00011N-2n
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Aug 2015 22:17:47 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZUMXJ-0006wI-Mr for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Aug 2015 22:17:46 +0000
Content-Disposition: inline
In-Reply-To: <000001d0ded7$1aa9e0a0$4ffda1e0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Tue, Aug 25, 2015 at 09:39:55AM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Tuesday, August 25, 2015 12:54 AM
> > To: Chao Yu
> > Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 2/2] f2fs: fix to release inode correctly
> > 
> 
> [snip]
> 
> > > +	 * if we skip truncate_node in remove_inode_page bacause we failed
> > > +	 * before, it's better to find another way to release resource of
> > > +	 * this inode (e.g. valid block count, node block or nid). Here we
> > > +	 * choose to add this inode to orphan list, so that we can call iput
> > > +	 * for releasing in orphan recovery flow.
> > > +	 *
> > > +	 * Note: we should add inode to orphan list before f2fs_unlock_op()
> > > +	 * so we can prevent losing this orphan when encoutering checkpoint
> > > +	 * and following suddenly power-off.
> > > +	 */
> > > +	if (err && err != -ENOENT) {
> > > +		err = acquire_orphan_inode(sbi);
> > > +		if (!err)
> > > +			add_orphan_inode(sbi, inode->i_ino);
> > 
> > 		Need this too?
> > 
> > 		if (err)
> > 			set_sbi_flag(sbi, SBI_NEED_FSCK);
> 
> We have another chance to release inode resource in following path:
>  - handle_failed_inode
>   - iput
>    - f2fs_evict_inode
>     - f2fs_truncate
>     - remove_inode_page
> 
> So I choose to set SBI_NEED_FSCK in the end of f2fs_evict_inode.

Oh, got it. :)

> 
> Thanks,

------------------------------------------------------------------------------
