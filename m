From: Hagbard Celine <hagbardcelin@gmail.com>
Subject: Re: BUG: kernel stack overflow when mounting with
 data_flush
Date: Sat, 30 Mar 2019 19:54:28 +0100
Message-ID: <CADoWrG9_5izaUMvB0mNLC7yp_Mnnm7yPrqcOvDL2ERR2YrkF2A@mail.gmail.com>
References: <CADoWrG_NTz29eyaa3fUti2sNBP4xp7-zfhDVkix=Kty4rD=Otw@mail.gmail.com>
 <35b643e5-562c-942d-67ce-4a9dbef66d16@huawei.com>
 <5725124a-95c8-cedb-d3a8-d8be86d260dd@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <hagbardcelin@gmail.com>) id 1hAJ7m-0005Vg-QM
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 30 Mar 2019 18:54:38 +0000
Received: from mail-lj1-f194.google.com ([209.85.208.194])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hAJ7k-005tjR-S8
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 30 Mar 2019 18:54:38 +0000
Received: by mail-lj1-f194.google.com with SMTP id h21so4664176ljk.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 30 Mar 2019 11:54:36 -0700 (PDT)
In-Reply-To: <5725124a-95c8-cedb-d3a8-d8be86d260dd@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>, yuchao0@huawei.com

First, yes it is caused by data_flush, this is what I am trying to
report. Without that option there is no "stack guard page was hit" and
no "kernel stack overflow" and kernel is stable.
This time I was using kernel 5.0.3, as can be seen in the log in my first mail.
I do not remember exactly what kernel version I tried the first time a
saw this bug, but I believe the mount option data_flush was just added
when I tried it the first time. The option has always lead to crash
here.

2019-03-30 8:29 GMT+01:00, Chao Yu <yuchao0@huawei.com>:
> Oh, sorry, it's quite possible that bug is caused by data_flush, could
> remove that mount option first?
>
> Thanks,
>
> On 2019/3/30 11:25, Chao Yu wrote:
>> Hi Hagbard,
>>
>> Sorry for the delay.
>>
>> On 2019/3/27 21:59, Hagbard Celine wrote:
>>> Hi, this is a long standing bug that I've hit before on older kernels,
>>> but I was not able to get the syslog saved because of the nature of
>>> the bug. This time I had booted form a pen-drive, and was able to save
>>> the log to it's efi-partition.
>>
>> Now which version of kernel do you use? and do you remember what is your
>> kernel version when this bug occured at first time?
>>
