From: folkert <folkert@vanheusden.com>
Subject: Re: [f2fs-dev] fsck: assertion failed
Date: Mon, 8 Jul 2013 08:47:40 +0200
Message-ID: <20130708064738.GI19245@belle.intranet.vanheusden.com>
References: <20130707101930.GD19245@belle.intranet.vanheusden.com>
	<1373259507.14296.24.camel@lcm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <folkert@vanheusden.com>) id 1Uw5En-0005Vh-4I
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 08 Jul 2013 06:47:53 +0000
Received: from keetweej.vanheusden.com ([80.101.105.103])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Uw5Ej-00017z-CG
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 08 Jul 2013 06:47:52 +0000
Content-Disposition: inline
In-Reply-To: <1373259507.14296.24.camel@lcm>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

> Thanks for your report.
> I have some questions. Did you umount and ran fsck? Otherwise, after SPO
> (Sudden Power Off) did you do it?

The system had a SPO yes. The fsck was on an unmounted filesytem.

> I wish to get a dump image of your disk. However your disk is such large
> one that I couldn't get it. So I have a request.
> Could you try it in smaller partition again whether succeed or fail?

I cannot, of course, give a filesystem dump as that disk contains rather
private data.


Folkert van Heusden

-- 
www.vanheusden.com/multitail - multitail is tail on steroids. multiple
               windows, filtering, coloring, anything you can think of
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
