From: cgxu519 <cgxu519@gmx.com>
Subject: Re: [PATCH] f2fs: remove default option setting in
 remount
Date: Tue, 18 Sep 2018 21:47:21 +0800
Message-ID: <a8cdaf63-c5fd-9391-2411-b61c8941351e@gmx.com>
References: <20180918062344.3102-1-cgxu519@gmx.com>
 <9bc59ef2-01cc-0cf1-1676-4d8a75514aad@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <cgxu519@gmx.com>) id 1g2GLv-0004bp-QL
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Sep 2018 13:47:43 +0000
Received: from mout.gmx.net ([212.227.15.19])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1g2GLt-004yj3-LX
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Sep 2018 13:47:43 +0000
In-Reply-To: <9bc59ef2-01cc-0cf1-1676-4d8a75514aad@kernel.org>
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
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

On 09/18/2018 09:20 PM, Chao Yu wrote:
> On 2018/9/18 14:23, Chengguang Xu wrote:
>> Currently we set default value to options before parsing remount options,
>> it will cause unexpected change of options which were specified in first
>> mount.
> Can you check below commit? It looks w/o it we may lose default option after
> remount.
>
> 498c5e9fcd10 ("f2fs: add default mount options to remount")

Hi Chao,

It looks like there was a bug in remount at that time, but I think the 
fix above is not correct.

from the patch '498c5e9fcd10', I think it was caused by clearing 
sbi->mount_opt.opt before

parsing. I think remount should not change the options which were 
specified by user in

previous mount unless user specifies in remount.

Thanks,
Chengguang
