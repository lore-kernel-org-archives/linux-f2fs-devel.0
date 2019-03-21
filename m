From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 3/5] f2fs-tools: Improve zoned model check
Date: Thu, 21 Mar 2019 14:32:30 +0800
Message-ID: <8a949957-30a6-de15-e23b-ceb96b07f943@huawei.com>
References: <20190318063959.21369-1-damien.lemoal@wdc.com>
 <20190318063959.21369-4-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1h6rFn-0005ML-OV
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Mar 2019 06:32:39 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h6rFm-000Dcj-Fn
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Mar 2019 06:32:39 +0000
In-Reply-To: <20190318063959.21369-4-damien.lemoal@wdc.com>
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

On 2019/3/18 14:39, Damien Le Moal wrote:
> Return an error if an unknown zoned model is reported for a device.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
