From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Re: [PATCH] fsck.f2fs: fix to set
 CP_LARGE_NAT_BITMAP_FLAG
Date: Fri, 19 Apr 2019 13:36:40 +0900
Message-ID: <CAD14+f2xhVt0Y91nBjj++ymYORbASQTHxpVHEhigYWqLnUkEPQ@mail.gmail.com>
References: <20190418074909.11102-1-yuchao0@huawei.com>
 <CAD14+f3ij7YA2BceZB23jHp=8qGCYTB5znBUJgPvYed7N7AXRg@mail.gmail.com>
 <5700d7e1-dee8-1e1c-dda9-c997c5b333c7@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hHLGk-0004xb-N2
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Apr 2019 04:36:58 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hHLGj-00FvC3-Ec
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Apr 2019 04:36:58 +0000
Received: by mail-qt1-f196.google.com with SMTP id f13so4155635qto.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 18 Apr 2019 21:36:57 -0700 (PDT)
In-Reply-To: <5700d7e1-dee8-1e1c-dda9-c997c5b333c7@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Chao and Jaegeuk.

On Fri, Apr 19, 2019 at 12:46 PM Chao Yu <yuchao0@huawei.com> wrote:
> I've sent two patches, could you please try them?
>
> Thanks

Thanks for the patches.

So it seems like I need to reformat my f2fs partitions, please confirm
if that's the case.
Also, if these patches break backward-compatibility, wouldn't it be
better to rename the feature and mark the old one deprecated?

I would like to see Jaegeuk's review before mkfs'ing again.

Thanks.
