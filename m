From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] mkfs.f2fs: do not need strdup for
	parse_feature
Date: Thu, 22 Sep 2016 18:43:12 +0800
Message-ID: <b3777bb5-ab9f-4d56-60a4-e0698c0d4307@huawei.com>
References: <1474452558-6490-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1bn1Td-0007p4-SL
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Sep 2016 10:43:37 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bn1Ta-0008NO-9C
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Sep 2016 10:43:37 +0000
In-Reply-To: <1474452558-6490-1-git-send-email-yunlong.song@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2016/9/21 18:09, Yunlong Song wrote:
> strdup is useless here, with no free op with its return value.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Acked-by: Chao Yu <yuchao0@huawei.com>


------------------------------------------------------------------------------
