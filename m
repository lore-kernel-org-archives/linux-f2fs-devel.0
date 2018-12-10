From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] fsck: Fix big endian platforms
Date: Mon, 10 Dec 2018 10:58:25 +0800
Message-ID: <f9b92578-da47-a13a-0b35-405a2ed731e1@huawei.com>
References: <20181208014531.2504-1-rosenp@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gWBmK-0007hQ-Tz
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Dec 2018 02:58:40 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gWBmI-00C5ja-LD
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Dec 2018 02:58:40 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 818825F2F7582
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 10 Dec 2018 10:58:28 +0800 (CST)
In-Reply-To: <20181208014531.2504-1-rosenp@gmail.com>
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
To: Rosen Penev <rosenp@gmail.com>, linux-f2fs-devel@lists.sourceforge.net

On 2018/12/8 9:45, Rosen Penev wrote:
> Since "fsck.f2fs: integrate sanity_check_inode to __check_inode_mode",
> big endian platforms have been broken due to an endianness bug.
> 
> More info: https://github.com/openwrt/openwrt/pull/1575

Nice catch!

> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
