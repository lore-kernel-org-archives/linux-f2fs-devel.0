From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2] F2FS customized migrate_page callback
Date: Tue, 20 Sep 2016 23:02:27 +0800
Message-ID: <f2a6a678-d87d-13ea-da6e-f131fc676d31@kernel.org>
References: <1474319007-87855-1-git-send-email-guoweichao@huawei.com>
	<fcba58f7-4cd5-23f9-d7bd-6616eedda470@kernel.org>
	<50788fd8-bbe0-706a-d31f-7b7ab99171c7@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bmMZR-0007yl-Le
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 20 Sep 2016 15:02:53 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bmMZN-0007XE-N2
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 20 Sep 2016 15:02:53 +0000
In-Reply-To: <50788fd8-bbe0-706a-d31f-7b7ab99171c7@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: guoweichao <guoweichao@huawei.com>, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
Cc: huxinwei@huawei.com

On 2016/9/20 10:20, guoweichao wrote:
> No, the 'page_count' of the old/new page for Page Cache has been maintained in 'migrate_page_move_mapping'. As atomic-written pages have an additional reference, we should update their 'page_count' here.

Got it. Now, this patch looks good to me. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

------------------------------------------------------------------------------
