From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Re: [PATCH v3 2/2] f2fs-tools: relocate chksum_offset
 for large_nat_bitmap feature
Date: Sun, 19 May 2019 05:09:19 +0900
Message-ID: <CAD14+f1+puy4M6rL_SbGt9vej=7LgK+qEjq71_878=oqSvjJ2Q@mail.gmail.com>
References: <20190514093340.40217-1-yuchao0@huawei.com>
 <20190514093340.40217-2-yuchao0@huawei.com>
 <CAD14+f2ckNUv9n-Zb9UL_ojX8=24tYBhT-SsrcpVNogqee2tkA@mail.gmail.com>
 <6bcbb5e8-55ad-49c1-bb77-f7f677ceb526@huawei.com>
 <CAD14+f3NHosrL=5UOBSMbFxQ91x-AuWOj_w=JYkJSnmfDgTkvA@mail.gmail.com>
 <CAD14+f0ZTmmLBXtmHF_Kz23JLSJy+UzpNxwSMV4rvSCse3y7EA@mail.gmail.com>
 <7e1bfa07-5ee8-a276-fe6a-6d79bd9270c3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hS5eD-0007b9-UM
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 18 May 2019 20:09:37 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hS5eC-006hrU-6p
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 18 May 2019 20:09:37 +0000
Received: by mail-qt1-f193.google.com with SMTP id t1so11900373qtc.12
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 18 May 2019 13:09:35 -0700 (PDT)
In-Reply-To: <7e1bfa07-5ee8-a276-fe6a-6d79bd9270c3@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Hey Chao,

Sorry for the late reply.

On Wed, May 15, 2019 at 6:23 PM Chao Yu <yuchao0@huawei.com> wrote:
> So I doubt that sit version bitmap is corrupted, could you add below log and
> reproduce this issue?

Just done it. The logs are at http://arter97.com/f2fs/v3__/

Thanks :)
