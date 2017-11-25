From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: remove repeated f2fs_bug_on
Date: Sat, 25 Nov 2017 20:01:17 +0800
Message-ID: <f408e65c-38c9-6eed-48ca-8a1d62360477@kernel.org>
References: <1511634868-29349-1-git-send-email-zhangzhikang1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1eIZ9W-0005bh-Ig
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 25 Nov 2017 12:01:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eIZ9V-0007Tg-SW
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 25 Nov 2017 12:01:46 +0000
In-Reply-To: <1511634868-29349-1-git-send-email-zhangzhikang1@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Zhikang Zhang <zhangzhikang1@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: ning.jia@huawei.com, heyunlei@huawei.com, shengyong1@huawei.com

On 2017/11/26 2:34, Zhikang Zhang wrote:
> f2fs: remove repeated f2fs_bug_on which has already existed
>       in function invalidate_blocks.
> 
> Signed-off-by: Zhikang Zhang <zhangzhikang1@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
