From: folkert <folkert@vanheusden.com>
Subject: assertion failed
Date: Sun, 23 Mar 2014 15:22:35 +0100
Message-ID: <20140323142235.GL18912@belle.intranet.vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <folkert@vanheusden.com>) id 1WRjIS-0002ON-N0
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 23 Mar 2014 14:22:44 +0000
Received: from keetweej.vanheusden.com ([80.101.105.103])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WRjIQ-0004EG-Ii
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 23 Mar 2014 14:22:44 +0000
Received: from belle.intranet.vanheusden.com (unknown [192.168.64.100])
	by keetweej.vanheusden.com (Postfix) with ESMTP id 9788015F98A
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sun, 23 Mar 2014 15:22:35 +0100 (CET)
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

Hi,

Got an assertion failed in fsck.f2fs:

Info: sector size = 512
Info: total sectors = 7503872 (in 512bytes)

Assertion failed!
[fsck_chk_node_blk: 209] nid == le32_to_cpu(node_blk->footer.nid)
 --> nid[0x5] blk_addr[0xc1d35] footer.nid[0x0]


Folkert van Heusden

-- 
Multi tail barnamaj mowahib li mora9abat attasjilat wa nataij awamir
al 7asoub. damj, talwin, mora9abat attarchi7 wa ila akhirih.
http://www.vanheusden.com/multitail/
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
