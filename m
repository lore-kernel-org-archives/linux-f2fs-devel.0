From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: let discard thread wait a little
 longer if dev is busy
Date: Sun, 8 Apr 2018 19:01:25 +0800
Message-ID: <10980e48-287c-635b-8dd5-464c8fc76a7a@kernel.org>
References: <1523171471-538-1-git-send-email-heyunlei@huawei.com>
 <1523171471-538-2-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1f584p-0006ED-0Y
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 11:01:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f584n-0031d5-Jt
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 11:01:38 +0000
In-Reply-To: <1523171471-538-2-git-send-email-heyunlei@huawei.com>
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

On 2018/4/8 15:11, Yunlei He wrote:
> This patch modify discard thread wait policy as below:
> 	issued       io_interrupted     wait time(ms)
> 1.        8                 0               50
> 2.      (0,8)               1               50
> 3.        0                 1              500 (dev is busy)
> 4.        0                 0            60000 (no candidates)
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
