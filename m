From: Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
Subject: Cold log explanation
Date: Sat, 10 Feb 2018 16:45:20 +0100
Message-ID: <20180210154519.GA11491@lazy.lzy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <piergiorgio.sartor@nexgo.de>) id 1ekXLL-0001Th-NW
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 10 Feb 2018 15:45:35 +0000
Received: from vsmx012.vodafonemail.xion.oxcs.net ([153.92.174.90])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ekXLJ-0007JZ-PK
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 10 Feb 2018 15:45:35 +0000
Received: from vsmx004.vodafonemail.xion.oxcs.net (unknown [192.168.75.198])
 by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTP id C360F8CDE3F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 10 Feb 2018 15:45:25 +0000 (UTC)
Received: from lazy.lzy (unknown [217.84.7.214])
 by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 987AACDFA6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 10 Feb 2018 15:45:23 +0000 (UTC)
Received: from lazy.lzy (localhost [127.0.0.1])
 by lazy.lzy (8.15.2/8.14.5) with ESMTPS id w1AFjKaj011515
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <linux-f2fs-devel@lists.sourceforge.net>; Sat, 10 Feb 2018 16:45:22 +0100
Received: (from red@localhost)
 by lazy.lzy (8.15.2/8.15.2/Submit) id w1AFjK0b011514
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 10 Feb 2018 16:45:20 +0100
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Hi all,

I noticed that "mkfs.f2fs" has an option, "-e",
to store certain files into the "cold log".

First, basic question, what is the "cold log" or,
better, what is the differnce between the "normal"
("warm", I guess) log and this one.

Second, it is possible to disable this list *after*
filesystem creation?
Maybe even with it mounted?

Thanks a lot in advance,

-- 

piergiorgio

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
