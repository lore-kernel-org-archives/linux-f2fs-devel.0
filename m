From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: Run xfstests for f2fs
Date: Wed, 17 Sep 2014 23:20:57 -0700
Message-ID: <20140918062057.GB2501@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <1410852658.7804.30.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XUV5W-0005ZT-VX
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Sep 2014 06:21:07 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XUV5V-0004Ct-Ji for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Sep 2014 06:21:06 +0000
Content-Disposition: inline
In-Reply-To: <1410852658.7804.30.camel@yhuang-dev>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Huang Ying <ying.huang@intel.com>
Cc: linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>

Hi,

On Tue, Sep 16, 2014 at 03:30:58PM +0800, Huang Ying wrote:
> Hi, Jaegeuk,
> 
> xfstests (http://oss.sgi.com/cgi-bin/gitweb.cgi?p=xfs/cmds/xfstests.git)
> is regression test suite for xfs and other file systems.  To run
> xfstests for f2fs, we need to either
> 
> - change fsck.f2fs to support "-n", which is default fsck option in
> xfstests.
> - change xfstests to call fsck.f2fs without any parameters.
> 
> I think choosing which solution depends on whether we will implemented a
> fsck which can repair file system.

I already implemented fsck.f2fs which fixes a corrupted partition.
There are two options: -a and -f.

> If so, we can add "-n" to fsck.f2fs.
> Otherwise, we can change xfstests.

http://patchwork.xfs.org/patch/7658/

I sent a patch before, and couldn't follow up the latest xfstests tree.
Could you check that?

Thanks,

> 
> Best Regards,
> Huang, Ying

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
