From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: Power Outage Corruption - Recovery?
Date: Sun, 10 Aug 2014 00:17:57 -0700
Message-ID: <20140810071629.GA1484@jaegeuk-mac02.mot-mobility.com>
References: <CABeR261Ep6fw+--kdtUCTEK0zktnRYQ=y6ScCKa8YEMXMxadOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XGNNY-0004Di-MZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 10 Aug 2014 07:17:20 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XGNNW-0007cn-TJ for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 10 Aug 2014 07:17:20 +0000
Content-Disposition: inline
In-Reply-To: <CABeR261Ep6fw+--kdtUCTEK0zktnRYQ=y6ScCKa8YEMXMxadOg@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Matt Parnell <mparnell@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Matt,

On Sat, Aug 09, 2014 at 10:15:15PM +0000, Matt Parnell wrote:
> I had a similar issue as a gentlemen whose message I recently read on this
> list, where power loss caused his f2fs partition to cause a kernel oops
> every time it was attempted to mount. I have the same issue. Is any form of
> recovery possible?

Ok, it seems that there is a roll-forward bug.
Could you mount it with -o disable_roll_forward?

> 
> Photorec was able to get most of it but there are two hard drive keys and a
> keepass database that I wish to try and recover.
> 
> Setting fsck.f2fs debug level to 9, I can get output like the below and
> even view the inode information with dump.f2fs.

I think I can add some codes in dump.f2fs to recover specific files with
inode numbers.
I'll look into this.

Thanks,

> 
> Is there a way I can, through a program or through hex editing, get these
> files back, or even repair the whole partition?
> 
> Thanks!
> 
> fsck output:
> 
> [fsck_chk_dentry_blk: 567] [  2] - no[0x8d] name[keys] len[0x4] ino[0x3a1]
> type[0x2]
> [fsck_chk_xattr_blk: 709] ino[0x3a1] x_nid[0x3a8]
> [fsck_chk_dentry_blk: 567] [  3] - no[0x2] name[storage.key] len[0xb]
> ino[0x3a2] type[0x1]
> [fsck_chk_xattr_blk: 709] ino[0x3a2] x_nid[0x3a3]
> [fsck_chk_dentry_blk: 567] [  3] - no[0x4] name[tmp.key] len[0x7]
> ino[0x3a4] type[0x1]
> [fsck_chk_xattr_blk: 709] ino[0x3a4] x_nid[0x3a5]
> [fsck_chk_dentry_blk: 567] [  3] - no[0x5] name[home.key] len[0x8]
> ino[0x3a6] type[0x1]
> [fsck_chk_xattr_blk: 709] ino[0x3a6] x_nid[0x3a7]
> [fsck_chk_dentry_blk: 588] [  3] Dentry Block [0xac3912] Done : dentries:3
> in 214 slots (len:255)
> 
> [fsck_chk_inode_blk: 379] Directory Inode: ino: 3a1 name: keys depth: 1
> child files: 3
> 
> inode dump:
> 
> Info: sector size = 512
> Info: total sectors = 92270592 (in 512bytes)
> [print_node_info:  77] Node ID [0x3a2:930] is inode
> i_mode                                [0x    81a4 : 33188]
> i_uid                                 [0x       0 : 0]
> i_gid                                 [0x       0 : 0]
> i_links                               [0x       1 : 1]
> i_size                                [0x    1000 : 4096]
> i_blocks                              [0x       3 : 3]
> i_atime                               [0x53b92ed2 : 1404645074]
> i_atime_nsec                          [0x234fa2de : 592421598]
> i_ctime                               [0x53ba3331 : 1404711729]
> i_ctime_nsec                          [0x3a88bfa8 : 982040488]
> i_mtime                               [0x53b90ec9 : 1404636873]
> i_mtime_nsec                          [0x374e1dc2 : 927866306]
> i_generation                          [0xf382a0df : 4085424351]
> i_current_depth                       [0x       1 : 1]
> i_xattr_nid                           [0x     3a3 : 931]
> i_flags                               [0x       0 : 0]
> i_pino                                [0x     3a1 : 929]
> i_namelen                             [0x       b : 11]
> i_name                                [storage.key]
> i_ext: fofs:0 blkaddr:693511 len:1
> i_addr[0]                             [0x  693511 : 6894865]
> i_addr[1]                             [0x       0 : 0]
> i_addr[2]                             [0x       0 : 0]
> i_addr[3]                             [0x       0 : 0]
> i_nid[0]                              [0x       0 : 0]
> i_nid[1]                              [0x       0 : 0]
> i_nid[2]                              [0x       0 : 0]
> i_nid[3]                              [0x       0 : 0]
> i_nid[4]                              [0x       0 : 0]
> 
> 
> Done.

> ------------------------------------------------------------------------------

> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
