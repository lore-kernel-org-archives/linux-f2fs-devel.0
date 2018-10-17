From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: remove request_list check in is_idle()
Date: Wed, 17 Oct 2018 11:11:50 +0800
Message-ID: <7a55158a-1987-1bd4-2595-339d1379eb88@huawei.com>
References: <d89936bb-398e-08c1-573f-b1bd54f3ca35@kernel.dk>
 <003df7ce-626c-e32b-909b-909b87e0c8f3@kernel.org>
 <5bbe6ae7-704e-dcaa-f798-959d8a1a00b3@kernel.dk>
 <20181016192314.GB29774@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gCcFo-0002te-3i
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Oct 2018 03:12:12 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gCcFm-003A54-83
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Oct 2018 03:12:12 +0000
In-Reply-To: <20181016192314.GB29774@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/10/17 3:23, Jaegeuk Kim wrote:
> Thanks Jens,
> 
> On top of the patch killing the dead code, I wrote another one to detect
> the idle time by the internal account logic like below. IMHO, it'd be
> better to decouple f2fs with other layers, if possible.
> 
> Thanks,
> 
>>From 85daf5190671b3d98ef779bdea77b4a046658708 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Tue, 16 Oct 2018 10:20:53 -0700
> Subject: [PATCH] f2fs: account read IOs and use IO counts for is_idle
> 
> This patch adds issued read IO counts which is under block layer.

Anyway, being aware of IO from f2fs and IO from block layer can be
separated into different patches, so adding this patch firstly looks good
to me.

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
