From: Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
Subject: f2fs on top ov LV
Date: Fri, 2 Feb 2018 18:29:48 +0100
Message-ID: <20180202172947.GA3981@lazy.lzy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <piergiorgio.sartor@nexgo.de>) id 1ehfT6-00077u-Ms
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 02 Feb 2018 17:49:44 +0000
Received: from vsmx009.vodafonemail.xion.oxcs.net ([153.92.174.87])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ehfT4-00082A-Ur
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 02 Feb 2018 17:49:44 +0000
Received: from vsmx001.vodafonemail.xion.oxcs.net (unknown [192.168.75.191])
 by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id 370BFC0507
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  2 Feb 2018 17:29:53 +0000 (UTC)
Received: from lazy.lzy (unknown [217.84.10.37])
 by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 166B030083F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  2 Feb 2018 17:29:50 +0000 (UTC)
Received: from lazy.lzy (localhost [127.0.0.1])
 by lazy.lzy (8.15.2/8.14.5) with ESMTPS id w12HTmTe004057
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 2 Feb 2018 18:29:50 +0100
Received: (from red@localhost)
 by lazy.lzy (8.15.2/8.15.2/Submit) id w12HTmKc004055
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 2 Feb 2018 18:29:48 +0100
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

I'm planning to prepare a Linux installation
on an USB flash drive.

The idea is to have /boot (with ext, since grub2
does not support f2fs yet) and / with f2fs.
Both on the USB flash drive while /home will be
somewhere else.

Now, I've a backup tool exploiting lvm snapshots
and I would like to use it.

This means / will be on top of an LV.

Does it make any sense to have f2fs over lvm?
Will still be some benefits from f2fs in this
setup?

How about snapshots? Could they cause problems?
Usually the filesystem mounted from lvm snapshot
has consistency issues, which are they usually
solved by journal.
I guess f2fs should be fine, but I would like to
confirm with experts here.

Of course, one possibility would be to use f2fs
on the raw partition, waiting for snapshot to
be implemented.
What's the plan about this?

Thanks a lot for any answers,

bye,

-- 

piergiorgio

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
