From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs-tools: add the max chunk size limit in
 sparse image
Date: Mon, 29 Oct 2018 18:30:39 +0800
Message-ID: <247d4b5f-51d7-83ec-75d5-98a4ee73143d@huawei.com>
References: <1539609897-88068-1-git-send-email-gaoming20@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gH4p5-0003bl-5T
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Oct 2018 10:31:03 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gH4oz-006CoZ-5p
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Oct 2018 10:31:03 +0000
In-Reply-To: <1539609897-88068-1-git-send-email-gaoming20@huawei.com>
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
To: Gao Ming <gaoming20@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
Cc: harry.shen@huawei.com, weidu.du@huawei.com, wvitao.wang@huawei.com, wangfei66@huawei.com

On 2018/10/15 21:24, Gao Ming wrote:
> Malloc Failure occurs in 32bit Windows, when using fastboot.exe flash the
>  f2fs sparse image filling with  up to 2G chunk size.
> 
> Signed-off-by: Gao Ming <gaoming20@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
