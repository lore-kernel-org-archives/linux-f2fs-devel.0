From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] f2fs fg_gc: node segment is prior to
 data segment selected victim
Date: Fri, 24 Feb 2017 10:03:15 +0800
Message-ID: <32393e49-80a7-86c9-6d1d-90110da5001a@huawei.com>
References: <20170222102900.152902-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1ch5EM-0002UN-CB
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Feb 2017 02:03:34 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ch5EL-0007Ed-Dn
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Feb 2017 02:03:34 +0000
In-Reply-To: <20170222102900.152902-1-houpengyang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Hou Pengyang <houpengyang@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/2/22 18:28, Hou Pengyang wrote:
> As data segment gc may lead dnode dirty, so the greedy cost for data segment should be
> valid blocks * 2, that is data segment is prior to node segment.
>
> Signed-off-by: Hou Pengyang <houpengyang@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>




------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
