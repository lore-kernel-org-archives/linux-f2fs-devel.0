From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: upset segment_info repair
Date: Tue, 01 Sep 2015 11:14:51 +0800
Message-ID: <004601d0e464$78f63bd0$6ae2b370$@samsung.com>
References: <1441012510-28607-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZWc31-0000z1-Vb
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Sep 2015 03:15:47 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZWc2y-00087S-BE
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Sep 2015 03:15:47 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NTZ00JIHAE0XBA0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Sep 2015 12:15:36 +0900 (KST)
In-reply-to: <1441012510-28607-1-git-send-email-heyunlei@huawei.com>
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
To: 'Yunlei He' <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Yunlei He [mailto:heyunlei@huawei.com]
> Sent: Monday, August 31, 2015 5:15 PM
> To: chao2.yu@samsung.com; jaegeuk@kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Cc: bintian.wang@huawei.com; Yunlei He
> Subject: [f2fs-dev][PATCH] f2fs: upset segment_info repair
> 
> upset segment_info like this:
> 
> 276000|161 0|0   4|70  3|0   3|0   0|0   0|91  4|0   4|232 4|39
> 276104|0   4|0   4|1   4|0   4|0   4|280 4|0   4|42  4|262 4|38
> 276204|179 4|89  4|39  4|24  4|0   4|96  4|3   4|428 4|0   4|118
> 276304|112 4|97  4|0   4|0   4|0   4|68  4|0   4|0   4|86  4|138
> 276404|0   4|0   0|166 5|39  4|101 0|111
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>

Looks good to me.

Reviewed-by: Chao Yu <chao2.yu@samsung.com>


------------------------------------------------------------------------------
