From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Re: [PATCH 1/3] f2fs: remove sleep_time under gc_urgent
Date: Tue, 14 May 2019 20:30:16 +0900
Message-ID: <CAD14+f2G5M7qqEvztd7nC=MNvSbLtkRKzNA89zGdYSb1FgP6LQ@mail.gmail.com>
References: <20190514063623.57162-1-qkrwngud825@gmail.com>
 <81acd624-8698-a584-f298-7e64ad77752d@huawei.com>
 <CAD14+f0Zia3oAi+QO+wCBrbV_=csp1SWB4BE7yN0h+=paZpg=w@mail.gmail.com>
 <8cd6214c-d15d-d6c6-224e-69ad7936605d@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hQVdi-00089v-Ty
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 May 2019 11:30:34 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hQVdh-00GV0M-I6
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 May 2019 11:30:34 +0000
Received: by mail-qk1-f194.google.com with SMTP id z128so10009072qkb.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 14 May 2019 04:30:33 -0700 (PDT)
In-Reply-To: <8cd6214c-d15d-d6c6-224e-69ad7936605d@huawei.com>
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
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi Chao,

On Tue, May 14, 2019 at 8:19 PM Chao Yu <yuchao0@huawei.com> wrote:
> > I've been using this(with a slightly different code) for years and yet to notice
> > any spikes in lags/slowdowns. Worst scenario, I'd just have to deal with an
> > added split second(100ms max?) delay in screen wake-up.
>
> I'm not sure about why this happened... maybe you need to do some test to
> analyse the root cause of it, filesystem/device fragment? too many undiscard
> space? or non-storage issue?

Um, I'm not sure you understood what I said.
What I meant is that I haven't found any issues with using an approach
like this(gc_urgent with 1ms sleep intervals) for years on various
Android devices.

> I agreed that it should done as soon as possible, but it needs to consider IO
> race in between Apps after screen wake-up and BGGC to avoid potential ANR.

I actually need to check whether vold turns off gc_urgent immediately
after screen turns itself back on.
I don't think we need to take potential ANR in to account *if* vold
stops gc_urgent right after screen-on. What do you think?

> It's userspace strategy, we can change both of them
> (vold_wait_time/gc_urgent_sleep_time) in userspace if current value doesn't make
> any sense.

Even the user can set the tunables themselves, the default should be
sensical imo.
An "urgent" GC that only GCs up-to 2 segments per second doesn't sound
that "urgent" :p

Thanks.
