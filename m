From: Tastky <tastky@gmail.com>
Subject: Re: [BUG] "kernel BUG at fs/f2fs/segment.c"
Date: Sat, 30 Nov 2013 18:59:53 +0100
Message-ID: <529A2799.4050305@gmail.com>
References: <529A1FBC.2000603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tastky@gmail.com>) id 1Vmopm-00005V-Ly
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Nov 2013 18:00:02 +0000
Received: from mail-bk0-f50.google.com ([209.85.214.50])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Vmopk-0007EY-Hl
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Nov 2013 18:00:02 +0000
Received: by mail-bk0-f50.google.com with SMTP id e11so4626981bkh.23
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 30 Nov 2013 09:59:54 -0800 (PST)
Received: from [192.168.1.188] (188-194-78-33-dynip.superkabel.de.
	[188.194.78.33])
	by mx.google.com with ESMTPSA id a4sm67844749bko.11.2013.11.30.09.59.53
	for <linux-f2fs-devel@lists.sourceforge.net>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Sat, 30 Nov 2013 09:59:53 -0800 (PST)
In-Reply-To: <529A1FBC.2000603@gmail.com>
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

Alright, I'm able to mount it again with the disable_roll_forward 
option. No other changes.

NB: There's a typo in the documentation at "disable_ext_identify": "so 
f2fs does not aware"

On 30.11.2013 18:26, Tastky wrote:
> Now the bug already happens when merely mounting the partition.

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
