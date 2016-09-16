From: Fan Li <fanofcode.li@samsung.com>
Subject: query about usage of kmap_atomic
Date: Fri, 16 Sep 2016 14:03:38 +0800
Message-ID: <000001d20fe0$15f144f0$41d3ced0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1bkmFF-0001PH-P6
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 16 Sep 2016 06:03:29 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1bkmFD-0004xq-OX
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 16 Sep 2016 06:03:29 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0ODL02H1W25JB470@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 16 Sep 2016 15:03:19 +0900 (KST)
Received: from lifan ([109.123.105.144])
	by mmp2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
	64bit
	(built May 5 2014)) with ESMTPA id <0ODL008Z725BZD10@mmp2.samsung.com>
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 16 Sep 2016 15:03:19 +0900 (KST)
Content-language: en-us
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

In f2fs_copy_page, kmap is used, rather than kmap_atomic, while some codes in
mm directory use kmap_atomic in scenarios where a whole page is copied.

How to determine which is better? I searched online and only thing I found is 
that "code which holds kmap_atomic needs be short and simple".

So is there any kind of guideline about how to use such function that will 
disable preemption? 
Thanks.

static inline void f2fs_copy_page(struct page *src, struct page *dst)
{
	char *src_kaddr = kmap(src);
	char *dst_kaddr = kmap(dst);

	memcpy(dst_kaddr, src_kaddr, PAGE_SIZE);
	kunmap(dst);
	kunmap(src);
}


------------------------------------------------------------------------------
