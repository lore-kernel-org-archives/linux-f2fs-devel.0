From: Chao Yu <chao@kernel.org>
Subject: Re: Userspace locks at f2fs_issue_flush kernel call,
 hard reset necessary
Date: Fri, 13 Oct 2017 19:13:59 +0800
Message-ID: <5fcb2a35-33cc-a711-6ac7-8a139877f3b7@kernel.org>
References: <CAETC-g9+HJXSL4mqgzdTBoaOyoXU5OwL9TsFxUURNRQQ2tryxA@mail.gmail.com>
 <CAETC-g8=z6LuzkxfMZBvuLeMBkFX2Aaais9_ydaoecaRUUpRfQ@mail.gmail.com>
 <ad969786-ffff-4093-1deb-9be1f0eab4fc@kernel.org>
 <CAETC-g9CJ_vzzD7a53QuXxYD8wX6oLPENq7nZTo-8PK6UANf-A@mail.gmail.com>
 <CAETC-g_vr_JcB6eTdFzyga9EyV799wKOpeYYnYGExThsvS+NgQ@mail.gmail.com>
 <82098916-57cf-2fe8-e2ec-b947ffaa0a74@huawei.com>
 <CAETC-g-XFUB6H=J6Zy_y7ywczOXPQEuTnugfbf1Tq8HpceR-AQ@mail.gmail.com>
 <76946108-47ec-1140-48ca-30b54ec8ec48@huawei.com>
 <CAETC-g_NZgRn82nNWO+ZiuDUo8hf6Td==1AXkyQVdCY-sODm0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1e2xv0-0005RK-0m
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Oct 2017 11:14:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e2xuy-0000za-Ra
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Oct 2017 11:14:17 +0000
In-Reply-To: <CAETC-g_NZgRn82nNWO+ZiuDUo8hf6Td==1AXkyQVdCY-sODm0w@mail.gmail.com>
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
To: "Marcelo \"Marc\" Ranolfi" <marc.2377@gmail.com>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Marcelo,

On 2017/10/13 12:19, Marcelo "Marc" Ranolfi wrote:
> Hello Chao,
> 
> I was holding for a while and taking care of other things, but now
> since I upgraded to kernel v4.13 (in fact I jumped to 4.13.3), I seem
> to be no longer affected by this problem.
> 
> My system has been running fine for over two weeks.

Good to hear about that. ;)

> 
> 
> I appreciate your help in this matter. Should I experience it once
> more, I'll ping you again.

No problem, I will keep an eye on this issue. :)

Thanks,

> 
> Thanks!
> 
> On Wed, Sep 13, 2017 at 11:22 PM, Chao Yu <yuchao0@huawei.com> wrote:
>> Hi Marcelo,
>>
>> Please add "f2fs: show flush list status in sysfs" first in your repo.
>>
>> And please try:
>> 1. mount without flush_merge option and do the test to see whether it is caused
>> by issue of the feature or lower block layer.
>>
>> For disabling the feature:
>> mount -o noflush_merge
>>
>> 2. do test with last codes in dev-test branch.
>>
>> If the problem is still there, please dump info with:
>> echo l > /proc/sysrq-trigger
>> echo w > /proc/sysrq-trigger
>> dmesg
>> cat /sys/kernel/debug/f2fs/status
>>
>> Thanks,
>>
>> On 2017/9/1 12:54, Marcelo "Marc" Ranolfi wrote:
>>> Hi,
>>>
>>> no problem at all.
>>>
>>> No, I never did ro remount before it happened. In fact its been a long
>>> while since I used ro.
>>>
>>>
>>> Regards
>>>
>>> On Thu, Aug 31, 2017 at 8:01 AM, Chao Yu <yuchao0@huawei.com> wrote:
>>>> Hi Marcelo,
>>>>
>>>> Sorry for the delay, :(
>>>>
>>>> I'd like ask, any possible that we did ro remount before the problem happened?
>>>>
>>>> Thanks,
>>>>
>>>> On 2017/8/24 1:26, Marcelo "Marc" Ranolfi wrote:
>>>>> Chao,
>>>>>
>>>>> I just had the same problem, with kernel 4.12.8 with patch _f2fs: fix
>>>>> out-of-order execution in f2fs_issue_flush_.
>>>>>
>>>>> On Tue, Aug 22, 2017 at 2:00 PM, Marcelo "Marc" Ranolfi
>>>>> <marc.2377@gmail.com> wrote:
>>>>>> Hi Chao
>>>>>>
>>>>>> I'm testing the kernel with your patch since last night. Will give new
>>>>>> feedback a couple of days/weeks about how it goes.
>>>>>>
>>>>>>
>>>>>> Thank you.
>>>>>>
>>>>>>
>>>>>>
>>>>>> On Mon, Aug 21, 2017 at 11:58 AM, Chao Yu <chao@kernel.org> wrote:
>>>>>>> Hi Marcelo,
>>>>>>>
>>>>>>> Thanks for the report!
>>>>>>>
>>>>>>> Would you have a try with below patch?
>>>>>>>
>>>>>>> f2fs: fix out-of-order execution in f2fs_issue_flush
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>> On 2017/8/16 15:24, Marcelo "Marc" Ranolfi wrote:
>>>>>>>> Just wanted to let you all know that this is still an issue, even with
>>>>>>>> the 4.12.7 kernel.
>>>>>>>>
>>>>>>>> The two most affected applications are qemu-system-x86_64 and totem.
>>>>>>>>
>>>>>>>> On Wed, Aug 9, 2017 at 3:04 AM, Marcelo "Marc" Ranolfi
>>>>>>>> <marc.2377@gmail.com> wrote:
>>>>>>>>> What follows is a bug report.
>>>>>>>>>
>>>>>>>>> I've been experiencing system lockups somewhat randomly. Sometimes an
>>>>>>>>> application freezes, and when I go check its properties, it says the
>>>>>>>>> process' Wait Channel is _f2fs_issue_flush_.
>>>>>>>>>
>>>>>>>>> Sometimes it's the qemu process (which I use via libvirt), other times
>>>>>>>>> it's Firefox, or Gnome Videos (totem) and it happened to Nemo once as
>>>>>>>>> well. I have screenshots if necessary.
>>>>>>>>>
>>>>>>>>> I've been tracking this with screenshots, and it's happenning every 4
>>>>>>>>> days - on average.
>>>>>>>>>
>>>>>>>>> When this happens, the process stays unresponsive no matter what. I tried:
>>>>>>>>>
>>>>>>>>> - Restarting swap
>>>>>>>>> - Restarting the Display Manager
>>>>>>>>> - Graceful shutdown / reboot - takes forever, doesn't work
>>>>>>>>> - Shutdown -k and unmounting filesystems from command line - root
>>>>>>>>> can't be unmounted unless -l used, no solution
>>>>>>>>>
>>>>>>>>> The only working solution is to reset the machine via power button or
>>>>>>>>> #reboot -f.
>>>>>>>>>
>>>>>>>>> I have:
>>>>>>>>>
>>>>>>>>> - Kingston SV300S37A120G - hardware is fine, I have other OS / filesystems on it
>>>>>>>>> - f2fs filesystem in a 40 GB partition, GPT
>>>>>>>>> - kernel 4.12.4 with systemd 234.11 - typical up-to-date Arch Linux setup.
>>>>>>>>>
>>>>>>>>> You gentlemen let me know if I provide more help.
>>>>>>>>>
>>>>>>>>> Best,
>>>>>>>>> Marc
>>>>>>>>
>>>>>>>> ------------------------------------------------------------------------------
>>>>>>>> Check out the vibrant tech community on one of the world's most
>>>>>>>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>>>>>>>> _______________________________________________
>>>>>>>> Linux-f2fs-devel mailing list
>>>>>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>>>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>>>>>>
>>>>>
>>>>> ------------------------------------------------------------------------------
>>>>> Check out the vibrant tech community on one of the world's most
>>>>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>>>>> _______________________________________________
>>>>> Linux-f2fs-devel mailing list
>>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>>>
>>>>>
>>>>
>>>
>>> .
>>>
>>

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
