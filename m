From: Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
Subject: f2fs not mountable: CRC validation failed
Date: Sun, 26 Mar 2017 22:12:03 +0200
Message-ID: <20170326201203.GA9286@lazy.lzy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <piergiorgio.sartor@nexgo.de>) id 1csEmO-00076E-1e
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 26 Mar 2017 20:28:48 +0000
Received: from vsmx010.vodafonemail.xion.oxcs.net ([153.92.174.88])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1csEmM-0004pL-P5
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 26 Mar 2017 20:28:48 +0000
Received: from vsmx002.vodafonemail.xion.oxcs.net (unknown [192.168.75.192])
	by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTP id 67AA5801AC
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sun, 26 Mar 2017 20:12:08 +0000 (UTC)
Received: from lazy.lzy (unknown [217.84.21.31])
	by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 70D5E3C03F3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sun, 26 Mar 2017 20:12:06 +0000 (UTC)
Received: from lazy.lzy (localhost [127.0.0.1])
	by lazy.lzy (8.15.2/8.14.5) with ESMTPS id v2QKC3J1009436
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sun, 26 Mar 2017 22:12:05 +0200
Received: (from red@localhost)
	by lazy.lzy (8.15.2/8.15.2/Submit) id v2QKC37L009435
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 26 Mar 2017 22:12:03 +0200
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

Hi all,

I apologize in advance in case this is the
wrong place for support (if so, please
point me in the right direction).

I've an USB stick formatted with f2fs,
used under Linux on a RPi2.
To be clear, it is a USB device, not
an SD card.

After a crash, the USB stick is not mountable
any more.
There is no HW error on the stick.

A "fsck" returns, among other information:

[f2fs_crc_valid: 486] CRC validation failed: cal_crc = 3543933224, blk_crc = 719768680 buff_size = 0xffc
[f2fs_crc_valid: 486] CRC validation failed: cal_crc = 1071250051, blk_crc = 2385854943 buff_size = 0xffc
[f2fs_do_mount:2018] Can't find valid checkpoint

And it does not perform any check / repair.

I'm a bit puzzled, I wonder if there is way
to force a repair, partially could be OK too.

Clearly, "fsck.f2fs -f" did not work.

Any chance to save some data?

f2fs-tools is version 1.8.0 (I guess it's latest).

System is Fedora 25, the tool is self compiled.

Thanks a lot in advance, in case other information
are required, please let me know.

bye,

-- 

piergiorgio

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
