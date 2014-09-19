From: Huang Ying <ying.huang@intel.com>
Subject: Re: Run xfstests for f2fs
Date: Fri, 19 Sep 2014 15:59:30 +0800
Message-ID: <1411113570.16814.2.camel@yhuang-mobile.sh.intel.com>
References: <1410852658.7804.30.camel@yhuang-dev>
	<20140918062057.GB2501@jaegeuk-mac02.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ying.huang@intel.com>) id 1XUt6S-00017q-B9
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 Sep 2014 07:59:40 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XUt6R-0001Ha-8X for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 Sep 2014 07:59:40 +0000
In-Reply-To: <20140918062057.GB2501@jaegeuk-mac02.hsd1.ca.comcast.net>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>

On Wed, 2014-09-17 at 23:20 -0700, Jaegeuk Kim wrote:
> Hi,
> 
> On Tue, Sep 16, 2014 at 03:30:58PM +0800, Huang Ying wrote:
> > Hi, Jaegeuk,
> > 
> > xfstests (http://oss.sgi.com/cgi-bin/gitweb.cgi?p=xfs/cmds/xfstests.git)
> > is regression test suite for xfs and other file systems.  To run
> > xfstests for f2fs, we need to either
> > 
> > - change fsck.f2fs to support "-n", which is default fsck option in
> > xfstests.
> > - change xfstests to call fsck.f2fs without any parameters.
> > 
> > I think choosing which solution depends on whether we will implemented a
> > fsck which can repair file system.
> 
> I already implemented fsck.f2fs which fixes a corrupted partition.
> There are two options: -a and -f.
> 
> > If so, we can add "-n" to fsck.f2fs.
> > Otherwise, we can change xfstests.
> 
> http://patchwork.xfs.org/patch/7658/
> 
> I sent a patch before, and couldn't follow up the latest xfstests tree.
> Could you check that?

Checked the latest xfstests git tree:

git://oss.sgi.com/xfs/cmds/xfstests.git

The latest git log item is:

commit cef47130ad17ff3a0c3cbdbd80d5dbc5f06cc876
Author: Brian Foster <bfoster@redhat.com>
Date:   Mon Sep 8 22:51:39 2014 +1000

    xfs/051: test buffer use after free race on I/O failure in XFS log
recovery

There is still no f2fs support.  Resend your patch?

Best Regards,
Huang, Ying



------------------------------------------------------------------------------
Slashdot TV.  Video for Nerds.  Stuff that Matters.
http://pubads.g.doubleclick.net/gampad/clk?id=160591471&iu=/4140/ostg.clktrk
