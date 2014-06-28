From: Brian Chadwick <brianchad@westnet.com.au>
Subject: fstrim fails on F2FS device
Date: Sat, 28 Jun 2014 16:43:38 +1000
Message-ID: <53AE641A.8050308@westnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <brianchad@westnet.com.au>) id 1X0mMo-0006xL-D0
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 28 Jun 2014 06:44:06 +0000
Received: from icp-osb-irony-out4.external.iinet.net.au ([203.59.1.220])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X0mMm-0001ap-4U for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 28 Jun 2014 06:44:06 +0000
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

Hi there

running fstrim on a F2FS partition gives the following output:

fstrim: /home: discard operation not supported.

kernel 3.16.0-rc2

Is this normal?

Cheers

Brian

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
