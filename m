From: "Marcelo \"Marc\" Ranolfi" <marc.2377@gmail.com>
Subject: Re: Userspace locks at f2fs_issue_flush kernel call,
 hard reset necessary
Date: Tue, 22 Aug 2017 14:00:40 -0300
Message-ID: <CAETC-g9CJ_vzzD7a53QuXxYD8wX6oLPENq7nZTo-8PK6UANf-A@mail.gmail.com>
References: <CAETC-g9+HJXSL4mqgzdTBoaOyoXU5OwL9TsFxUURNRQQ2tryxA@mail.gmail.com>
 <CAETC-g8=z6LuzkxfMZBvuLeMBkFX2Aaais9_ydaoecaRUUpRfQ@mail.gmail.com>
 <ad969786-ffff-4093-1deb-9be1f0eab4fc@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <marc.2377@gmail.com>) id 1dkCXq-0005gi-0h
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 22 Aug 2017 17:00:50 +0000
Received: from mail-lf0-f67.google.com ([209.85.215.67])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1dkCXn-00061h-OJ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 22 Aug 2017 17:00:49 +0000
Received: by mail-lf0-f67.google.com with SMTP id f7so7663910lfg.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 22 Aug 2017 10:00:47 -0700 (PDT)
In-Reply-To: <ad969786-ffff-4093-1deb-9be1f0eab4fc@kernel.org>
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
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Chao

I'm testing the kernel with your patch since last night. Will give new
feedback a couple of days/weeks about how it goes.


Thank you.



On Mon, Aug 21, 2017 at 11:58 AM, Chao Yu <chao@kernel.org> wrote:
> Hi Marcelo,
>
> Thanks for the report!
>
> Would you have a try with below patch?
>
> f2fs: fix out-of-order execution in f2fs_issue_flush
>
> Thanks,
>
> On 2017/8/16 15:24, Marcelo "Marc" Ranolfi wrote:
>> Just wanted to let you all know that this is still an issue, even with
>> the 4.12.7 kernel.
>>
>> The two most affected applications are qemu-system-x86_64 and totem.
>>
>> On Wed, Aug 9, 2017 at 3:04 AM, Marcelo "Marc" Ranolfi
>> <marc.2377@gmail.com> wrote:
>>> What follows is a bug report.
>>>
>>> I've been experiencing system lockups somewhat randomly. Sometimes an
>>> application freezes, and when I go check its properties, it says the
>>> process' Wait Channel is _f2fs_issue_flush_.
>>>
>>> Sometimes it's the qemu process (which I use via libvirt), other times
>>> it's Firefox, or Gnome Videos (totem) and it happened to Nemo once as
>>> well. I have screenshots if necessary.
>>>
>>> I've been tracking this with screenshots, and it's happenning every 4
>>> days - on average.
>>>
>>> When this happens, the process stays unresponsive no matter what. I tried:
>>>
>>> - Restarting swap
>>> - Restarting the Display Manager
>>> - Graceful shutdown / reboot - takes forever, doesn't work
>>> - Shutdown -k and unmounting filesystems from command line - root
>>> can't be unmounted unless -l used, no solution
>>>
>>> The only working solution is to reset the machine via power button or
>>> #reboot -f.
>>>
>>> I have:
>>>
>>> - Kingston SV300S37A120G - hardware is fine, I have other OS / filesystems on it
>>> - f2fs filesystem in a 40 GB partition, GPT
>>> - kernel 4.12.4 with systemd 234.11 - typical up-to-date Arch Linux setup.
>>>
>>> You gentlemen let me know if I provide more help.
>>>
>>> Best,
>>> Marc
>>
>> ------------------------------------------------------------------------------
>> Check out the vibrant tech community on one of the world's most
>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
