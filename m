From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: mark is_extension_exist() inline
Date: Sat, 20 Apr 2019 10:12:01 +0800
Message-ID: <e85faa6b-8a85-fe3f-65a1-3e89c83aca83@huawei.com>
References: <20190417095738.7918-1-qkrwngud825@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hHfUE-0001iH-5l
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Apr 2019 02:12:14 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hHfUC-000w5n-4w
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Apr 2019 02:12:14 +0000
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 6BF25B1D2509AFEF59A0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 20 Apr 2019 10:12:01 +0800 (CST)
In-Reply-To: <20190417095738.7918-1-qkrwngud825@gmail.com>
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
To: Park Ju Hyung <qkrwngud825@gmail.com>, linux-f2fs-devel@lists.sourceforge.net

On 2019/4/17 17:57, Park Ju Hyung wrote:
> The caller set_file_temperature() is marked as inline as well.
> It doesn't make much sense to leave is_extension_exist() un-inlined.
> 
> Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
