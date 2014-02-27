From: Alex <hbx7d@yandex.com>
Subject: Regression in kernel 3.14.0-rc1
Date: Thu, 27 Feb 2014 19:02:44 +0400
Message-ID: <174911393513364@web17j.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hbx7d@yandex.com>) id 1WJ2il-0007AI-2S
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Feb 2014 15:17:59 +0000
Received: from forward15.mail.yandex.net ([95.108.130.119])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WJ2ij-0002PD-JV
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Feb 2014 15:17:59 +0000
Received: from web17j.yandex.ru (web17j.yandex.ru [5.45.198.58])
	by forward15.mail.yandex.net (Yandex) with ESMTP id 6DFAA9E1F09
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 27 Feb 2014 19:02:45 +0400 (MSK)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Hello,

After reading phoronix's f2fs benchmarks http://www.phoronix.com/scan.php?page=article&item=linux_314_ssdfs&num=2 (3rd picture) did kernel bisect and it resulted in this commit https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/?id=fb5566da .

PS Tried the latest tree from f2fs dev branch with the same results https://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=695fd1ed .

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
