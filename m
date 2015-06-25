From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [GIT PULL] f2fs updates for v4.2
Date: Thu, 25 Jun 2015 07:32:36 +0100
Message-ID: <20150625063235.GV17109@ZenIV.linux.org.uk>
References: <20150624202401.GA40031@jaegeuk-mac02.mot.com>
	<CA+55aFycRo0ttWw5kAgf=tDrfz-hvhSsjveu9LqdXH-RNbXE3A@mail.gmail.com>
	<20150625043334.GT17109@ZenIV.linux.org.uk>
	<20150625054917.GA43469@jaegeuk-mac02.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Z80iN-00009F-5D
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Jun 2015 06:32:47 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z80iK-00081y-1R
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Jun 2015 06:32:47 +0000
Content-Disposition: inline
In-Reply-To: <20150625054917.GA43469@jaegeuk-mac02.hsd1.ca.comcast.net>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>

On Wed, Jun 24, 2015 at 10:50:10PM -0700, Jaegeuk Kim wrote:

> Right, I missed merging the fix-up patch in linux-next into my pull-request.
> At a glance, I think there is no problem; except 80 column width, though.
> 
> Also, agreed that I need to take a look at deleting the dentry to deal with that
> failure case.

	Why not set the symlink up first and create a directory entry only
if that succeeds?  Looks like it's less work that way...

------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
