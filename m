From: Jun He <jhe@cs.wisc.edu>
Subject: Invoke GC by user?
Date: Fri, 13 May 2016 11:47:29 -0500
Message-ID: <CABW1wHRZddgZsbBwqT3W1rLkNz9R6Dw7u=3ozpVy26x7_rfYDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jun.n.he@gmail.com>) id 1b1GG7-0002gg-Jy
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 May 2016 16:48:15 +0000
Received: from mail-oi0-f45.google.com ([209.85.218.45])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1b1GG6-00022o-TM
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 May 2016 16:48:15 +0000
Received: by mail-oi0-f45.google.com with SMTP id v145so179200374oie.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 13 May 2016 09:48:14 -0700 (PDT)
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

Hi,

I understand that "F2FS does cleaning both on demand and in the
background. On-demand cleaning is triggered when there are not enough
free segments to serve VFS calls". Is there any way to start GC to
clean all garbage even when the free segments are enough?

Thanks,
Jun

------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
