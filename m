From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Re: [PATCH v3 2/2] f2fs-tools: relocate chksum_offset
 for large_nat_bitmap feature
Date: Sun, 19 May 2019 18:19:06 +0900
Message-ID: <CAD14+f1xgYKAnzqLb-ZpzbeskZegGHXbrJ+vEHZe19_Jp3pBTQ@mail.gmail.com>
References: <20190514093340.40217-1-yuchao0@huawei.com>
 <20190514093340.40217-2-yuchao0@huawei.com>
 <CAD14+f2ckNUv9n-Zb9UL_ojX8=24tYBhT-SsrcpVNogqee2tkA@mail.gmail.com>
 <6bcbb5e8-55ad-49c1-bb77-f7f677ceb526@huawei.com>
 <CAD14+f3NHosrL=5UOBSMbFxQ91x-AuWOj_w=JYkJSnmfDgTkvA@mail.gmail.com>
 <CAD14+f0ZTmmLBXtmHF_Kz23JLSJy+UzpNxwSMV4rvSCse3y7EA@mail.gmail.com>
 <7e1bfa07-5ee8-a276-fe6a-6d79bd9270c3@huawei.com>
 <CAD14+f1+puy4M6rL_SbGt9vej=7LgK+qEjq71_878=oqSvjJ2Q@mail.gmail.com>
 <0f89b0b6-5cc5-6618-72e5-8a2f81947161@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hSHyk-0006yh-JA
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 19 May 2019 09:19:38 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hSHyV-0086ON-Cj
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 19 May 2019 09:19:38 +0000
Received: by mail-qk1-f194.google.com with SMTP id z6so7066199qkl.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 19 May 2019 02:19:23 -0700 (PDT)
In-Reply-To: <0f89b0b6-5cc5-6618-72e5-8a2f81947161@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On Sun, May 19, 2019 at 2:09 PM Chao Yu <chao@kernel.org> wrote:
> I've found one bug when repairing cp_payload blocks, could you try it?
>
> [PATCH] fsck.f2fs: fix to repair cp_loads blocks at correct position

http://arter97.com/f2fs/v3__cp

After the patch, 2nd, 3rd and the 4th run all returns the same output.
I think now fsck only needs to run once :)

Final question though, is it expected that the first run to print 62MB
worth of logs?

Thanks.
