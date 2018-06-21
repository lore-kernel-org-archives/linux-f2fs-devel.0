From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: fix a hungtask problem caused by
 congestion_wait
Date: Thu, 21 Jun 2018 16:39:21 +0800
Message-ID: <f860fabb-5702-6503-bc76-f5f838301ec8@huawei.com>
References: <1529563746-8608-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fVv8p-0002WT-Ex
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Jun 2018 08:40:31 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fVv8n-002DMB-Cv
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Jun 2018 08:40:31 +0000
In-Reply-To: <1529563746-8608-1-git-send-email-heyunlei@huawei.com>
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
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: zhangdianfang@huawei.com

On 2018/6/21 14:49, Yunlei He wrote:
> This patch fix hungtask problem which can be reproduced as follow:
> 
> Thread 0~3:
> while true
> do
>         touch /xxx/test/file_xxx
> done
> 
> Thread 4 write a new checkpoint every three seconds.
> 
> In the meantime, fio start 16 threads for randwrite.
> 
> With my debug info, cycles num will exceed 1000 in function
> f2fs_sync_dirty_inodes, and most of cycle will be dropped
> into congestion_wait() and sleep more than 20ms. Cycles num
> reduced to 3 with this patch.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
