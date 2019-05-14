From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/3] f2fs: remove sleep_time under gc_urgent
Date: Tue, 14 May 2019 19:19:23 +0800
Message-ID: <8cd6214c-d15d-d6c6-224e-69ad7936605d@huawei.com>
References: <20190514063623.57162-1-qkrwngud825@gmail.com>
 <81acd624-8698-a584-f298-7e64ad77752d@huawei.com>
 <CAD14+f0Zia3oAi+QO+wCBrbV_=csp1SWB4BE7yN0h+=paZpg=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hQVT4-00029M-Vy
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 May 2019 11:19:35 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hQVT3-003M6I-1Y
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 May 2019 11:19:34 +0000
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id EA194433A485E4BD73FE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 14 May 2019 19:19:24 +0800 (CST)
In-Reply-To: <CAD14+f0Zia3oAi+QO+wCBrbV_=csp1SWB4BE7yN0h+=paZpg=w@mail.gmail.com>
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
To: Ju Hyung Park <qkrwngud825@gmail.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi Ju Hyung,

On 2019/5/14 17:51, Ju Hyung Park wrote:
> Hi Chao,
> 
> On Tue, May 14, 2019 at 6:20 PM Chao Yu <yuchao0@huawei.com
> <mailto:yuchao0@huawei.com>> wrote:
>> IIRC, related interfaces (gc_urgent/urgent_sleep_time) were introduced for
>> Android Go
> 
> These are used for all Android devices since Pie, and is triggered when Android
> thinks the device is idle. iirc, screen state is one of them to ensure that the
> user isn't using any apps.
> 
>> may be stuck due to racing with IO from GC. Anyway I think we need to set proper
>> interval for background GC, IMO, 1 ms is too short...
> 
> I've been using this(with a slightly different code) for years and yet to notice
> any spikes in lags/slowdowns. Worst scenario, I'd just have to deal with an
> added split second(100ms max?) delay in screen wake-up.

I'm not sure about why this happened... maybe you need to do some test to
analyse the root cause of it, filesystem/device fragment? too many undiscard
space? or non-storage issue?

> 
> I think we're thinking too theoretical and failing to address real practical issues.
> 
> Also, if that's a concern, the userspace shouldn't use gc_urgent at all. We have
> other tunables for tuning regular GC.

Yes, we can, but there is no sysfs entry can make GC running as IO
non-awareness, I guess that's why Jaegeuk expose independent entry.

> 
> Similar to fstrim on traditional filesystems(blocking everything until all trim
> is done), this is supposed to be a userspace hint to run GC aggressively in
> system where the in-kernel is_idle() isn't enough, and as it's an interface for
> "aggressive" GC, it should finish as soon as possible imo.

I agreed that it should done as soon as possible, but it needs to consider IO
race in between Apps after screen wake-up and BGGC to avoid potential ANR.

> Userspace should be calling this when it knows that the device is idle, or when
> it's willing to sacrifice some latency.
> 
> The default 500ms didn't make much sense and causes real-world problem as vold
> only waits 480 seconds.

I don't remember the threshold in Android Go (Oreo)...

It's userspace strategy, we can change both of them
(vold_wait_time/gc_urgent_sleep_time) in userspace if current value doesn't make
any sense.

Thanks,

> 
> Thanks.
