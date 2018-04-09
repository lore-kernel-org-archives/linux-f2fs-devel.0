From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: check cur_valid_map_mir & raw_sit
 block count when flush sit entries
Date: Mon, 9 Apr 2018 09:17:58 +0800
Message-ID: <f60dea10-500b-4861-d527-7d3c50b5b33f@huawei.com>
References: <1523219321-10895-1-git-send-email-zhangzhikang1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f5LSh-0002iH-Pc
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Apr 2018 01:19:11 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f5LSf-004CJ1-6b
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Apr 2018 01:19:11 +0000
In-Reply-To: <1523219321-10895-1-git-send-email-zhangzhikang1@huawei.com>
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
To: Zhikang Zhang <zhangzhikang1@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/4/9 4:28, Zhikang Zhang wrote:
> We should check valid_map_mir and block count to ensure
> the flushed raw_sit is correct.
> 
> Signed-off-by: Zhikang Zhang <zhangzhikang1@huawei.com>
> Signed-off-by: Yunlei He <heyunlei@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
