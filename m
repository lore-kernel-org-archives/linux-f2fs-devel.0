From: Daeho Jeong <daeho.jeong@samsung.com>
Subject: How do I execute regression test for f2fs?
Date: Fri, 01 Sep 2017 05:19:47 +0000
Message-ID: <20170901051947epcms1p477656fd4bbe3f2b8d85d0f57df3c47fd@epcms1p4>
References: <CGME20170901051947epcms1p477656fd4bbe3f2b8d85d0f57df3c47fd@epcms1p4>
Reply-To: daeho.jeong@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <daeho.jeong@samsung.com>)
 id 1dnefj-0002kQ-2j
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Sep 2017 05:39:15 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1dnefg-0000NS-S4
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Sep 2017 05:39:15 +0000
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20170901051950epoutp02a01b5cc7952e27eb63b2af50366b5228~gJTZOUJYD2867328673epoutp02C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  1 Sep 2017 05:19:50 +0000 (GMT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org" <chao@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi,

I have a question about developing f2fs. :-)

I've made a patch for f2fs, but I don't know how to execute regression
test, xfstest, for f2fs. Do you have some guide document or url about
how to use xfstest for f2fs?

Otherwise, is there another regression testing method for f2fs?

Best Regards,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
