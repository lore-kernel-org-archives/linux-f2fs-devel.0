From: Josh Dener <denerjosh@yahoo.com>
Subject: Reservation amount
Date: Sun, 18 Oct 2015 04:58:05 +0000 (UTC)
Message-ID: <906568999.1957861.1445144285260.JavaMail.yahoo@mail.yahoo.com>
References: <906568999.1957861.1445144285260.JavaMail.yahoo@mail.yahoo.com>
Reply-To: Josh Dener <denerjosh@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <denerjosh@yahoo.com>) id 1Zng5c-0001Zs-Rp
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 18 Oct 2015 05:01:00 +0000
Received: from nm37-vm1.bullet.mail.gq1.yahoo.com ([98.136.216.236])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Zng5a-0004Qk-Sj
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 18 Oct 2015 05:01:00 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi,

Where does this formula come from?


config.reserved_segments =

    (2 * (100 / config.overprovision + 1) + 6)


Is there a formal justification for it?

Thanks.

------------------------------------------------------------------------------
