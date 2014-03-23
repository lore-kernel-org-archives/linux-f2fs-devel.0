From: Kim Jaegeuk <jaegeuk.kim@gmail.com>
Subject: Re: assertion failed
Date: Mon, 24 Mar 2014 02:45:31 +0900
Message-ID: <CAOtxgydC0Kxbs+o4hODvgi7FSCVzCqH3vXtdbfRKnE4AjHZ2hg@mail.gmail.com>
References: <20140323142235.GL18912@belle.intranet.vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@gmail.com>) id 1WRmSo-0000Z9-08
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 23 Mar 2014 17:45:38 +0000
Received: from mail-pd0-f179.google.com ([209.85.192.179])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WRmSm-0001y0-Sb
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 23 Mar 2014 17:45:37 +0000
Received: by mail-pd0-f179.google.com with SMTP id w10so4369027pde.38
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sun, 23 Mar 2014 10:45:31 -0700 (PDT)
In-Reply-To: <20140323142235.GL18912@belle.intranet.vanheusden.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: folkert <folkert@vanheusden.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi,

Thank you for the report.
Could you share the kernel and f2fs-tools versions?
Let me check.
Thank you,

2014-03-23 23:22 GMT+09:00 folkert <folkert@vanheusden.com>:
> Hi,
>
> Got an assertion failed in fsck.f2fs:
>
> Info: sector size = 512
> Info: total sectors = 7503872 (in 512bytes)
>
> Assertion failed!
> [fsck_chk_node_blk: 209] nid == le32_to_cpu(node_blk->footer.nid)
>  --> nid[0x5] blk_addr[0xc1d35] footer.nid[0x0]
>
>
> Folkert van Heusden
>
> --
> Multi tail barnamaj mowahib li mora9abat attasjilat wa nataij awamir
> al 7asoub. damj, talwin, mora9abat attarchi7 wa ila akhirih.
> http://www.vanheusden.com/multitail/
> ----------------------------------------------------------------------
> Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
>
> ------------------------------------------------------------------------------
> Learn Graph Databases - Download FREE O'Reilly Book
> "Graph Databases" is the definitive new guide to graph databases and their
> applications. Written by three acclaimed leaders in the field,
> this first edition is now available. Download your free book today!
> http://p.sf.net/sfu/13534_NeoTech
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
