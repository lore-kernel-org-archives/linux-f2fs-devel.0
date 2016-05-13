From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: Invoke GC by user?
Date: Fri, 13 May 2016 10:05:07 -0700
Message-ID: <20160513170507.GA27525@jaegeuk.gateway>
References: <CABW1wHRZddgZsbBwqT3W1rLkNz9R6Dw7u=3ozpVy26x7_rfYDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b1GWb-0002eW-Cc
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 May 2016 17:05:17 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b1GWa-000761-9M
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 May 2016 17:05:17 +0000
Content-Disposition: inline
In-Reply-To: <CABW1wHRZddgZsbBwqT3W1rLkNz9R6Dw7u=3ozpVy26x7_rfYDg@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jun He <jhe@cs.wisc.edu>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hello,

On Fri, May 13, 2016 at 11:47:29AM -0500, Jun He wrote:
> Hi,
> 
> I understand that "F2FS does cleaning both on demand and in the
> background. On-demand cleaning is triggered when there are not enough
> free segments to serve VFS calls". Is there any way to start GC to
> clean all garbage even when the free segments are enough?

There are two ways.
1. mount option: -o background_gc=sync
  This will invoke forground gc instead of background one periodically.

2. ->ioctl(F2FS_IOC_GARBAGE_COLLECT)
  This can invoke one round of forground or background gc by user directly.
 
Thanks,

> 
> Thanks,
> Jun
> 
> ------------------------------------------------------------------------------
> Mobile security can be enabling, not merely restricting. Employees who
> bring their own devices (BYOD) to work are irked by the imposition of MDM
> restrictions. Mobile Device Manager Plus allows you to control only the
> apps on BYO-devices by containerizing them, leaving personal data untouched!
> https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
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
