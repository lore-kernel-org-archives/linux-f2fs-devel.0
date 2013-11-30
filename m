From: Tastky <tastky@gmail.com>
Subject: Re: [BUG] "kernel BUG at fs/f2fs/segment.c"
Date: Sat, 30 Nov 2013 18:29:37 +0100
Message-ID: <529A2081.1040904@gmail.com>
References: <529A1FBC.2000603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tastky@gmail.com>) id 1VmoMU-0007Pu-6I
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Nov 2013 17:29:46 +0000
Received: from mail-bk0-f51.google.com ([209.85.214.51])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VmoMR-0004ou-WD
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Nov 2013 17:29:46 +0000
Received: by mail-bk0-f51.google.com with SMTP id 6so4644479bkj.24
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 30 Nov 2013 09:29:37 -0800 (PST)
Received: from [192.168.1.188] (188-194-78-33-dynip.superkabel.de.
	[188.194.78.33])
	by mx.google.com with ESMTPSA id j6sm57293076bki.17.2013.11.30.09.29.36
	for <linux-f2fs-devel@lists.sourceforge.net>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Sat, 30 Nov 2013 09:29:37 -0800 (PST)
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

Correction: Accessing the partition continued to work, but anything that 
called a stat (like ls) on the file or tried another alteration froze. 
Also, just viewing the broken file still worked as well.

On 30.11.2013 18:26, Tastky wrote:
> The system would continue to run, but the process that tries to alter
> the file (and any subsequent ones trying to access the partition) would
> freeze indefinitely and become unkillable. Moving the file was fine,
> however.

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
