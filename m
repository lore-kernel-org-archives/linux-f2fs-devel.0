From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH -next] f2fs: fix non static symbol warning
Date: Thu, 25 Aug 2016 22:11:21 +0800
Message-ID: <a5ea9c94-8f7f-0980-7a44-942f79785fcd@kernel.org>
References: <1471965839-8389-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bcvNc-0001q2-F7
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Aug 2016 14:11:40 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bcvNb-0003T0-Pj
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Aug 2016 14:11:40 +0000
In-Reply-To: <1471965839-8389-1-git-send-email-weiyj.lk@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Wei Yongjun <weiyj.lk@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>, Chao Yu <yuchao0@huawei.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2016/8/23 23:23, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fixes the following sparse warning:
> 
> fs/f2fs/data.c:969:12: warning:
>  symbol 'f2fs_grab_bio' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Chao Yu <yuchao0@huawei.com>

------------------------------------------------------------------------------
