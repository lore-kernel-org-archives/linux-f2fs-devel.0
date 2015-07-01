From: Chao Yu <chao2.yu@samsung.com>
Subject: [RFC] maintain stable and dev code separately
Date: Wed, 01 Jul 2015 10:00:52 +0800
Message-ID: <00f501d0b3a1$d8443680$88cca380$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZA7LE-0003yH-Hp
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Jul 2015 02:01:36 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZA7LC-0006vx-Hd
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Jul 2015 02:01:36 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NQS00XTDDMFKID0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Jul 2015 11:01:27 +0900 (KST)
Content-language: zh-cn
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
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

Now in our f2fs git repository, we have only one major 'dev' branch
for collecting last reviewed and tested patches.

And in merge window of Linux, we do not update dev branch with last
patches, so in this period of two weeks, it's hard for your developers
to rebase the right and last dev branch for developing, and there maybe
more conflict when we merge patches.

Have you considered to maintain stable and dev code separately? 
Something like:

One 'devel' branch updated with new patches after being reviewed and tested;
One 'stable' branch updated periodically from 'devel' branch.

In merge window linus can pull all patches from 'stable' branch, and meanwhile
we can develop base on 'devel' branch.

And also Fengguang Wu's lkp project can test both branch well, especially for
last patches sent in merge window.

Regards,
Yu


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
