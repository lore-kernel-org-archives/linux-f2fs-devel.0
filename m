From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/3] f2fs: remove unsafe bitmap checking
Date: Fri, 24 Feb 2017 09:45:41 -0800
Message-ID: <20170224174541.GA39009@jaegeuk.local>
References: <20170223091807.36175-1-houpengyang@huawei.com>
	<20170223091807.36175-2-houpengyang@huawei.com>
	<9b4cf979-75be-752d-775c-9f76f00d5788@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1chJwF-0004JB-NJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Feb 2017 17:45:51 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1chJwE-0005Zk-Ki
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Feb 2017 17:45:51 +0000
Content-Disposition: inline
In-Reply-To: <9b4cf979-75be-752d-775c-9f76f00d5788@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 02/24, Chao Yu wrote:
> On 2017/2/23 17:18, Hou Pengyang wrote:
> > proc A:                      proc B:
> > - writeback_sb_inodes
> > - __writeback_single_inode   
> > - do_writepages
> > - f2fs_write_node_pages       
> > - f2fs_balance_fs_bg         - write_checkpoint
> > - build_free_nids            - flush_nat_entries
> > - __build_free_nids          - __flush_nat_entry_set
> > - ra_meta_pages              - get_next_nat_page
> > - current_nat_addr           - set_to_next_nat
> > [do nat_bitmap checking]     - f2fs_change_bit
> 
> Both flows were protected by nat_tree_lock, so we don't need to worry about such
> case?

The nat_tree_lock doesn't cover ra_meta_pages in proc A.

Thanks,

> 
> Thanks,
> 
> > 
> > For proc A, nat_bitmap and nat_bitmap_mir would be compared without lock_op and 
> > nm_i->nat_tree_lock, while proc B is changing nat_bitmap/nat_bitmap_ver in cp.
> > 
> > So it is normal for nat_bitmap/nat_bitmap diffrence under such scenario.
> > 
> > This patch fix this by removing the monitoring point.
> > 
> > [Fix: 599a09b f2fs: check in-memory nat version bitmap]
> > Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
> > ---
> >  fs/f2fs/node.h | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
> > index d3d2893..3fc9c4b 100644
> > --- a/fs/f2fs/node.h
> > +++ b/fs/f2fs/node.h
> > @@ -209,12 +209,6 @@ static inline pgoff_t current_nat_addr(struct f2fs_sb_info *sbi, nid_t start)
> >  		(seg_off << sbi->log_blocks_per_seg << 1) +
> >  		(block_off & (sbi->blocks_per_seg - 1)));
> >  
> > -#ifdef CONFIG_F2FS_CHECK_FS
> > -	if (f2fs_test_bit(block_off, nm_i->nat_bitmap) !=
> > -			f2fs_test_bit(block_off, nm_i->nat_bitmap_mir))
> > -		f2fs_bug_on(sbi, 1);
> > -#endif
> > -
> >  	if (f2fs_test_bit(block_off, nm_i->nat_bitmap))
> >  		block_addr += sbi->blocks_per_seg;
> >  
> > 
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
