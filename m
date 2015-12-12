From: Marc Lehmann <schmorp@schmorp.de>
Subject: status of 3.18 branch?
Date: Sat, 12 Dec 2015 22:27:21 +0100
Message-ID: <20151212212721.GB3480@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1a7rhS-0005uj-HJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Dec 2015 21:27:30 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a7rhQ-0006sq-Ks
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Dec 2015 21:27:30 +0000
Received: from [10.0.0.5] (helo=doom.schmorp.de)
	by mail.nethype.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1a7rhJ-0005T0-R9
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Dec 2015 21:27:21 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by doom.schmorp.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1a7rhJ-0000QQ-MC
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Dec 2015 21:27:21 +0000
Received: from root by cerebro.laendle with local (Exim 4.84)
	(envelope-from <root@schmorp.de>) id 1a7rhJ-0000xq-Lh
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Dec 2015 22:27:21 +0100
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

I was just told that my instructions for SMR drives no longer work because
the f2fs 3.18 branch no longer exists, and indeed, it seems to be gone:

   # git clone -b linux-3.18 git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
   Cloning into 'f2fs'...
   warning: Could not find remote branch linux-3.18 to clone.

Was this intentional? If yes, is there an old copy somewhere (I don't have
one unfortunately)?

Thanks!

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
