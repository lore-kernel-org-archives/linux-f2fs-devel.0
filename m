From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: check node page again in write end io
Date: Wed, 10 Jan 2018 23:16:58 +0800
Message-ID: <bc16116a-fb05-0541-980c-70127cf9500d@kernel.org>
References: <1515573443-22939-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1eZI7r-0000EX-0L
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Jan 2018 15:17:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eZI7n-0001nT-1K
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Jan 2018 15:17:10 +0000
In-Reply-To: <1515573443-22939-1-git-send-email-heyunlei@huawei.com>
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
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: ning.jia@huawei.com

On 2018/1/10 16:37, Yunlei He wrote:
> Check node page again in write end io in case of
> data corruption during inflght IO.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
