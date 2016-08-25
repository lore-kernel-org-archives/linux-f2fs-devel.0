From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: remove unnecessary initialization
Date: Thu, 25 Aug 2016 22:10:51 +0800
Message-ID: <0232b8f4-9f95-ec53-2255-e36be4ca3c8f@kernel.org>
References: <20160823121047.6428-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bcvN7-0007Tm-T3
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Aug 2016 14:11:09 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bcvN5-0003P9-LQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Aug 2016 14:11:09 +0000
In-Reply-To: <20160823121047.6428-1-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2016/8/23 20:10, Sheng Yong wrote:
> `flags' is used to save value from userspace, there is no need to
> initialize it, and FS_FL_USER_VISIBLE is the mask for getflags.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>

Acked-by: Chao Yu <yuchao0@huawei.com>

------------------------------------------------------------------------------
