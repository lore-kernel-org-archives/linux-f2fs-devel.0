From: Huang Ying <ying.huang@intel.com>
Subject: Run xfstests for f2fs
Date: Tue, 16 Sep 2014 15:30:58 +0800
Message-ID: <1410852658.7804.30.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ying.huang@intel.com>) id 1XTnEF-0006g0-IC
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 16 Sep 2014 07:31:11 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XTnE9-00007u-Sg for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 16 Sep 2014 07:31:11 +0000
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

Hi, Jaegeuk,

xfstests (http://oss.sgi.com/cgi-bin/gitweb.cgi?p=xfs/cmds/xfstests.git)
is regression test suite for xfs and other file systems.  To run
xfstests for f2fs, we need to either

- change fsck.f2fs to support "-n", which is default fsck option in
xfstests.
- change xfstests to call fsck.f2fs without any parameters.

I think choosing which solution depends on whether we will implemented a
fsck which can repair file system.  If so, we can add "-n" to fsck.f2fs.
Otherwise, we can change xfstests.

Best Regards,
Huang, Ying



------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce.
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
