From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: f2fs: introduce f2fs_issue_discard() to clean up
Date: Tue, 26 Nov 2013 17:53:16 +0300
Message-ID: <20131126145315.GA27436@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dan.carpenter@oracle.com>) id 1VlK14-0004a2-ER
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Nov 2013 14:53:30 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VlK13-0007nA-5H
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Nov 2013 14:53:29 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Hello Jaegeuk Kim,

The patch 3fa7fb17dc9a: "f2fs: introduce f2fs_issue_discard() to clean
up" from Nov 12, 2013, leads to the following static checker warning:
	"fs/f2fs/segment.c:274 f2fs_issue_discard()
	 warn: should 'blklen << sbi->log_sectors_per_block' be a 64 bit
	 type?"

fs/f2fs/segment.c
   270  static void f2fs_issue_discard(struct f2fs_sb_info *sbi,
   271                                  block_t blkstart, block_t blklen)
   272  {
   273          sector_t sector_addr = blkstart << sbi->log_sectors_per_block;
   274          sector_t sector_len = blklen << sbi->log_sectors_per_block;

block_t is a 32 bit type and sector_t is a 64 bit type.  The upper 32
bits of the sector_t are not used because the shift will wrap.

   275  
   276          blkdev_issue_discard(sbi->sb->s_bdev, sector_addr, sector_len,
   277                                                          GFP_NOFS, 0);
   278          trace_f2fs_issue_discard(sbi->sb, blkstart, blklen);
   279  }

regards,
dan carpenter


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
