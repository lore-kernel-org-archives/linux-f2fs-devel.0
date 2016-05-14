From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: Kernel panic in F2FS mount on NVMe SSD.
Date: Fri, 13 May 2016 17:59:21 -0700
Message-ID: <20160514005921.GA29412@jaegeuk.gateway>
References: <D87A37E7A4AA544D853031D9A919C70B168FC5E3@avsrvexchmbx2.microsemi.net>
	<20160505000958.GA72128@jaegeuk.gateway>
	<D87A37E7A4AA544D853031D9A919C70B168FC904@avsrvexchmbx2.microsemi.net>
	<20160505034815.GA73673@jaegeuk.gateway>
	<D87A37E7A4AA544D853031D9A919C70B168FD685@avsrvexchmbx2.microsemi.net>
	<20160507174952.GB92790@jaegeuk.gateway>
	<D87A37E7A4AA544D853031D9A919C70B16901358@avsrvexchmbx2.microsemi.net>
	<20160509172608.GB810@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b1NvW-00009b-MW
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 14 May 2016 00:59:30 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b1NvV-0003ug-NW
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 14 May 2016 00:59:30 +0000
Content-Disposition: inline
In-Reply-To: <20160509172608.GB810@jaegeuk.gateway>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Stephen Bates <stephen.bates@microsemi.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hello,

On Mon, May 09, 2016 at 10:26:08AM -0700, Jaegeuk Kim wrote:
> On Mon, May 09, 2016 at 03:35:25PM +0000, Stephen Bates wrote:
> > > 
> > > We could figure out how to improve them. :)
> > > 
> > > I've been preparing two patches under testing right now.
> > >  - f2fs: fallocate data blocks in single locked node page
> > >  - f2fs: read node blocks ahead when truncating blocks
> > > 
> > > Thanks,
> > 
> > Let me know when and where I can pull these and I can do some testing too.
> 
> Okay, Chao Yu gave more improvement, so now I'm starting to do stress tests.
> Once getting some good signs, I'll let you know.
> 
> Meanwhile, you may take a look at any testing patches from:
> http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git/log/?h=dev

I think the patches are ready.
You may be able to test with the above up-to-date branch.

Thanks,


> 
> Thanks,
> 
> > 
> > Thanks!
> > 
> > Stephen
> 
> ------------------------------------------------------------------------------
> Find and fix application performance issues faster with Applications Manager
> Applications Manager provides deep performance insights into multiple tiers of
> your business applications. It resolves application problems quickly and
> reduces your MTTR. Get your free trial!
> https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
