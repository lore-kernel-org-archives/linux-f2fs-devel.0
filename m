From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] fsck.f2fs: fix to set
 CP_LARGE_NAT_BITMAP_FLAG
Date: Fri, 19 Apr 2019 12:59:23 +0800
Message-ID: <3d15f545-1c5c-29fd-453e-e62ec284e216@huawei.com>
References: <20190418074909.11102-1-yuchao0@huawei.com>
 <CAD14+f3ij7YA2BceZB23jHp=8qGCYTB5znBUJgPvYed7N7AXRg@mail.gmail.com>
 <5700d7e1-dee8-1e1c-dda9-c997c5b333c7@huawei.com>
 <CAD14+f2xhVt0Y91nBjj++ymYORbASQTHxpVHEhigYWqLnUkEPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hHLci-0003dd-O3
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Apr 2019 04:59:40 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hHLcg-00FxFS-4j
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Apr 2019 04:59:40 +0000
In-Reply-To: <CAD14+f2xhVt0Y91nBjj++ymYORbASQTHxpVHEhigYWqLnUkEPQ@mail.gmail.com>
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
To: Ju Hyung Park <qkrwngud825@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2019/4/19 12:36, Ju Hyung Park wrote:
> Hi Chao and Jaegeuk.
> 
> On Fri, Apr 19, 2019 at 12:46 PM Chao Yu <yuchao0@huawei.com> wrote:
>> I've sent two patches, could you please try them?
>>
>> Thanks
> 
> Thanks for the patches.
> 
> So it seems like I need to reformat my f2fs partitions, please confirm
> if that's the case.

I think you can try new fsck to check whether it can fix the corrupted image first?

> Also, if these patches break backward-compatibility, wouldn't it be
> better to rename the feature and mark the old one deprecated?

Yeah, that would be one option, I agree and prefer to listen to Jaegeuk's point
of view.

> 
> I would like to see Jaegeuk's review before mkfs'ing again.
> 
> Thanks.
> .
> 
