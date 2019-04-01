From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 4/4 v2] f2fs-tools: Fix multi-device format
 with zoned devices
Date: Mon, 1 Apr 2019 20:13:09 +0800
Message-ID: <7a1a6586-54fa-a6aa-b439-9fd22856599a@huawei.com>
References: <20190327075410.15784-1-damien.lemoal@wdc.com>
 <20190327075410.15784-5-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hAvoV-0002KE-Js
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Apr 2019 12:13:19 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hAvoU-006kMr-Dp
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Apr 2019 12:13:19 +0000
In-Reply-To: <20190327075410.15784-5-damien.lemoal@wdc.com>
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
To: Damien Le Moal <damien.lemoal@wdc.com>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On 2019/3/27 15:54, Damien Le Moal wrote:
> There is no need to require conventional zones for a zoned block device
> that is not the first device of a multi-device volume. As a result,
> there is no need to check the number of conventional zones of the
> device if the device index is not 0.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
