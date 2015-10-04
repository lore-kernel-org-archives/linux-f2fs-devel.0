From: Marc Lehmann <schmorp@schmorp.de>
Subject: dir_level explained?
Date: Sun, 4 Oct 2015 11:56:47 +0200
Message-ID: <20151004095647.GC3177@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1Zig2J-0002Q6-SC
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 04 Oct 2015 09:56:55 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zig2I-0007SU-Op
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 04 Oct 2015 09:56:55 +0000
Received: from [10.0.0.5] (helo=doom.schmorp.de)
	by mail.nethype.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1Zig2C-00064d-Nf
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 04 Oct 2015 09:56:48 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by doom.schmorp.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1Zig2B-0003cd-UA
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 04 Oct 2015 09:56:47 +0000
Received: from root by cerebro.laendle with local (Exim 4.84)
	(envelope-from <root@schmorp.de>) id 1Zig2B-0000st-TV
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 04 Oct 2015 11:56:47 +0200
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

In all my tests I intentionally didn't play with dir_level, to get an idea of
baseline performance. I also wasn't worried because my standard response to
slow random reads is dmcache, but now that I realised I can't use dmcache
with these drives, I got more interested in dir_level.

If I understand it correctly, higher values of dir_level potentially waste
more space but gain performance. However, I have no clue about what the
trade-off really is.

Could you explain what kind of extra space usage I can expect from higher
levels of dir_level, or what the values mean?

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
