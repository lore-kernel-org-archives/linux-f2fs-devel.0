From: Marc Lehmann <schmorp@schmorp.de>
Subject: blog article about f2fs on smr drives
Date: Thu, 8 Oct 2015 15:56:35 +0200
Message-ID: <20151008135635.GA5459@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZkBgc-0007Ms-CA
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Oct 2015 13:56:46 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZkBgZ-0003ZJ-OU
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Oct 2015 13:56:45 +0000
Received: from [10.0.0.5] (helo=doom.schmorp.de)
	by mail.nethype.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZkBgT-00013n-0E
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Oct 2015 13:56:37 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by doom.schmorp.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZkBgR-0002kJ-OV
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Oct 2015 13:56:35 +0000
Received: from root by cerebro.laendle with local (Exim 4.84)
	(envelope-from <root@schmorp.de>) id 1ZkBgR-0001Qf-Nq
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Oct 2015 15:56:35 +0200
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
To: linux-f2fs-devel@lists.sourceforge.net

Hi!

I write a short and very preliminary blog article about hoe to get SMR drives
to work, fast, with f2fs.

   http://blog.schmorp.de/2015-10-08-smr-archive-drives-fast-now.html

This is just a heads up - due to external events, I haven't been able to
look into new developments (such as background_gc=sync), which look evry
exciting, but I think this informastion needs to get out, as there are a
lot of people who suffer badly with these drives, mostly due to kernel
issues, but of course also due to the filesystem situation.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
