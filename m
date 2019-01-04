From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix compile warnings: 'struct *'
 declared inside parameter list
Date: Fri, 4 Jan 2019 10:31:04 +0800
Message-ID: <31670bbc-131f-3ec0-421f-d0114c91e449@huawei.com>
References: <1546517198-9555-1-git-send-email-zhangzhikang1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gfFGd-0000jM-On
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Jan 2019 02:31:23 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gfFGc-00Floc-At
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Jan 2019 02:31:23 +0000
In-Reply-To: <1546517198-9555-1-git-send-email-zhangzhikang1@huawei.com>
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
To: Zhikang Zhang <zhangzhikang1@huawei.com>, jaegeuk@kernel.org
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2019/1/3 20:06, Zhikang Zhang wrote:
> We meet these compile warnings below, which caused by missing declare structs:
> struct f2fs_io_info, struct extent, struct f2fs_sb_info.
> 
> warning: 'struct f2fs_io_info' declared inside parameter list
> warning: 'struct extent_info' declared inside parameter list
> warning: 'struct f2fs_sb_info' declared inside parameter list
> 
> Signed-off-by: Zhikang Zhang <zhangzhikang1@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
