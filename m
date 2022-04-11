Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A9FC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 Apr 2022 03:10:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ndkRR-0002M0-Rv; Mon, 11 Apr 2022 03:10:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1ndkRQ-0002Lu-Q3
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Apr 2022 03:10:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vy7cGqKWX5bM3XsXS2hGMPulQx9Goicl5T2rJ6O0mOE=; b=fwGuoZCVPvVzsc0vlvLytTB//R
 rBoKYeh2SLqJXs7bdu/1wTZcdXV47e2XUKohtyD0si2U+4F5VgGbWyMpewnqIGhBpur4CKse/kfsy
 UgNR35+Er6TQd415a5vipYTllQjomrYh1ImN8P9ZpQyK1w7qjGa1gFngRX5lAwcAMRk0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vy7cGqKWX5bM3XsXS2hGMPulQx9Goicl5T2rJ6O0mOE=; b=RYFZy8a63J8Adxirbi74uGT3wc
 08mcalqjbrYJkBqQeeonhTEwbEahKSQq1j3N2ImQzyWjXsMFhWaqLKRNdVGCRtUandhLYbZQfHA46
 p6tG8WPT2181XVi7Du36ttzCfd1iXiAsw3d9jw5NGNxs8DBs3rdYAtagGNrOqW8uP5GE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1ndkRL-0002G0-7L
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Apr 2022 03:10:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 27B1461090;
 Mon, 11 Apr 2022 03:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D571FC385A1;
 Mon, 11 Apr 2022 03:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649646599;
 bh=4LmMfrR1QPPGbqdrcE2YtRn/sHGcdWwD5i6OKaZjEiE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tsPzZgJJ03fB0EumFGmnf7UJoBExhLPh1wWuvvCfR7OXTgxJU6X/ebA85ODaWUfyv
 vjPFk18aq4jiGN1pijBqs9YiBMObDL1jf5wIvUr6sgR5zFPTB8lhd0nQJHEssvXFTr
 erNUI7FS+YnP+J/NcM9hemXslNyAj9rc9vcWzg/HfjaeQtHlrbmcaL76bGPI/jWe7H
 vw7WiA+hFeW8wYcy8sqmA7l+vS4tM5zSI2bCJTJPY86soUHt3hVu37mZlOg6FsdqzR
 kNsxBVc+XM+pxaexoYCOjoGYdBVYmmlXuqSy0foal+IXbXsgYHkii2Mh87JUQH/hfj
 im3zudH+2KMGw==
Message-ID: <2f5b7291-da06-0895-8e75-c7a37251b47e@kernel.org>
Date: Mon, 11 Apr 2022 11:09:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Dongliang Mu <mudongliangabcd@gmail.com>
References: <20220408052207.209856-1-dzm91@hust.edu.cn>
 <f125ece9-872e-39d9-48a5-15b85508f6b6@kernel.org>
 <CAD-N9QV7RUfBreaVOmC0JUwVfieM3kOYigOav8=vpAoak6Uc6A@mail.gmail.com>
 <7e896205-027d-32e2-32b5-8951231132ac@kernel.org>
 <CAD-N9QXM_xds692Lh-QZc5aL01uRivLGrNnxJys41hiTUfKE5w@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAD-N9QXM_xds692Lh-QZc5aL01uRivLGrNnxJys41hiTUfKE5w@mail.gmail.com>
X-Headers-End: 1ndkRL-0002G0-7L
Subject: Re: [f2fs-dev] [PATCH] fs: f2fs: remove WARN_ON in
 f2fs_is_valid_blkaddr
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 syzbot+763ae12a2ede1d99d4dc@syzkaller.appspotmail.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/4/9 14:42, Dongliang Mu wrote:
> On Sat, Apr 9, 2022 at 11:46 AM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2022/4/9 9:34, Dongliang Mu wrote:
>>> On Sat, Apr 9, 2022 at 8:27 AM Chao Yu <chao@kernel.org> wrote:
>>>>
>>>> On 2022/4/8 13:22, Dongliang Mu wrote:
>>>>> From: Dongliang Mu <mudongliangabcd@gmail.com>
>>>>>
>>>>> In f2fs_is_valid_blkaddr, if type is DATA_GENERIC_ENHANCE or
>>>>> DATA_GENERIC_ENHANCE_READ, it invokes WARN_ON(1) not matter
>>>>> blkaddr is in the range or not.
>>>>
>>>> If we run into the path where we invoke WARN_ON(1) in f2fs_is_valid_blkaddr(),
>>>> It means f2fs image may be broken, or there is a bug in f2fs.
>>>>
>>>> So, do you suffer any related issue in your environment?
>>>
>>> related issue? Can you explain a little?
>>>
>>> If you mean if this warning occurs, any other issues or crash
>>
>> I mean have you seen any warning info printed in the path of
>> f2fs_is_valid_blkaddr() before applying this patch, and if so, w/ what
>> reproducer? or you just figure out this patch from perspective of code
>> review?
> 
> Yes, I have seen both warning information from Syzbot [1] and my local
> syzkaller instance.
> 
> In f2fs_is_valid_blkaddr, if the following condition is satisfied,
> i.e., blkaddr is not in the right range [2], it will directly invoke
> one WARN_ON.
> 
> if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
>                   blkaddr < MAIN_BLKADDR(sbi))) {
> 
> This is the case on Syzbot.
> 
> Otherwise, it will jump into __is_bitmap_valid. And if the following
> condition is satisfied [3], it will trigger another WARN_ON.
> 
> exist = f2fs_test_bit(offset, se->cur_valid_map);
> if (!exist && type == DATA_GENERIC_ENHANCE) {
> 
> This appears in my local syzbot instance, but unfortunately it does
> not get any reproducer.

Oh, it occurs in syzbot test, I guess it is possible that f2fs prints such
warning info after blkaddr of node/data block was fuzzed to invalid one.

I prefer to keep WARN_ON() to catch more info of bugs found by non-fuzzed
type test.

Thoughts?

Thanks,

> 
> [1] https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsyzkaller.appspot.com%2Fbug%3Fextid%3D763ae12a2ede1d99d4dc&amp;data=04%7C01%7Cchao.yu%40oppo.com%7Cff92e63621b24fc75a4908da19f45860%7Cf1905eb1c35341c5951662b4a54b5ee6%7C0%7C0%7C637850834521060840%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=UVSSS9IknYLJHzqqJAN5HmPgJ8GNczvi6%2FuQf2n3vlY%3D&amp;reserved=0
> [2] https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Ffs%2Ff2fs%2Fcheckpoint.c%23L187&amp;data=04%7C01%7Cchao.yu%40oppo.com%7Cff92e63621b24fc75a4908da19f45860%7Cf1905eb1c35341c5951662b4a54b5ee6%7C0%7C0%7C637850834521060840%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=Sf%2Bx8WCAXf5c4%2Bins46saTsTN5uNTrnIceAP3oCWnQw%3D&amp;reserved=0
> [3] https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Ffs%2Ff2fs%2Fcheckpoint.c%23L135&amp;data=04%7C01%7Cchao.yu%40oppo.com%7Cff92e63621b24fc75a4908da19f45860%7Cf1905eb1c35341c5951662b4a54b5ee6%7C0%7C0%7C637850834521060840%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=Ly%2FBL5oFAWZmXwbN6TaYCExroDE8%2Fsli1alaJwR4wvU%3D&amp;reserved=0
> 
> 
>>
>> Thanks,
>>
>>> behaviors are generated? I tested on the syzbot. After removing the
>>> WARN_ON, there is no abnormal issue or crash behaviors followed with
>>> the corresponding reproducer.
>>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>> Fix this by removing WARN_ON.
>>>>>
>>>>> Note that, syzbot patch testing does not incur any further issues
>>>>>
>>>>> Reported-by: syzbot+763ae12a2ede1d99d4dc@syzkaller.appspotmail.com
>>>>> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
>>>>> ---
>>>>>     fs/f2fs/checkpoint.c | 2 --
>>>>>     1 file changed, 2 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>>>> index f5366feea82d..521498b2dd8c 100644
>>>>> --- a/fs/f2fs/checkpoint.c
>>>>> +++ b/fs/f2fs/checkpoint.c
>>>>> @@ -158,7 +158,6 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
>>>>>                 f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
>>>>>                          blkaddr, exist);
>>>>>                 set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>>> -             WARN_ON(1);
>>>>>         }
>>>>>         return exist;
>>>>>     }
>>>>> @@ -196,7 +195,6 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>>>>>                         f2fs_warn(sbi, "access invalid blkaddr:%u",
>>>>>                                   blkaddr);
>>>>>                         set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>>> -                     WARN_ON(1);
>>>>>                         return false;
>>>>>                 } else {
>>>>>                         return __is_bitmap_valid(sbi, blkaddr, type);
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
