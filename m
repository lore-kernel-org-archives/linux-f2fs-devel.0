Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8DDC6FD1F
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 25 Mar 2023 07:26:04 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pfyHp-00063C-Rm;
	Sat, 25 Mar 2023 07:26:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pfyHm-000636-1n
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Mar 2023 07:25:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4Ze8rHxbigDT8IAV+tt7HDmcHC7b8ZsYEKfCm+5DaHU=; b=lolT+7csYzD/a2jV9e1mXRrUks
 /gjX4IGQyaZTDXVnp/0yMcPNIs09onS/doUOG/x6BejxW2E9LywaMY8pvXoqCturxZwuEemAEHK23
 uXyNrqpiyruIdo6RY+QzG804KpV0Dw9HohmchlRHofLY617U0xLvjdiNnkICGYaUNIuA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4Ze8rHxbigDT8IAV+tt7HDmcHC7b8ZsYEKfCm+5DaHU=; b=K48061VEqLMRaDHaTm1tT9n4SN
 iLv+X7z/981Ytzy8pwoiKdnyUk1ljio8NwsOjyXWi0u0FTGyxZLODJH4zCknOkztK0hod7yMH7fth
 j5eNvYCsJOZWYFKwgk62cZwqEGreGePpx6A4qO+MdEO/dODLPCmWkYykMG9WfvkGA/14=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pfyHg-002cnT-2R for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Mar 2023 07:25:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0229760A5C;
 Sat, 25 Mar 2023 07:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97B9C433EF;
 Sat, 25 Mar 2023 07:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1679729144;
 bh=ntEalkUYAGwjABuQ56Tv6dEUJ7uXtdZVc6w4gHVNPp0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=S8j7Jo+/Py1QDPuJxYBwBV5JXrI0Yk63/fCXos0cWxtd0BYDsMFZgyRyZMw7hS3Ue
 7CRsh5nNqKuuy3tDaXJj0id7BSq/YrJeIHNEcryYRpNHjZQIrZM4JWGnBNSrfi2vkb
 dlgMaMLt2kU0LPgy7TMvm54ZNH+kjC3BcLwgW1vTi9G3xpTeYTXkcRRWQZ+EMcZrUY
 opSFyUCnRlARr2RDqiP31x40LEcTg5K8xLs9NhOs47Qa2I3ynXIcdN6mu2MXEu4gm4
 axAiHhp06eXBA3hPfFkl1HOFGInMxs36ZAlNeaZZgYTzpDz7ahP5ALtP4RKsOXcWxR
 Kf3yCKGht1Gkg==
Message-ID: <7524b5b2-95c1-f39f-c375-bdfb55778c5d@kernel.org>
Date: Sat, 25 Mar 2023 15:25:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <CGME20230313094825epcms2p71e6cb549251dc55e8d202dd64b9913a6@epcms2p7>
 <20230313094825epcms2p71e6cb549251dc55e8d202dd64b9913a6@epcms2p7>
 <a24d66ad-4048-fd5c-ae47-2dd17c87bcbe@kernel.org>
 <ZBzMql6DkrUWiRKP@google.com>
 <35dd1eea-f1b9-418e-5f97-cfd10b7ff803@kernel.org>
 <ZB3Vz9w2ybNVSY8C@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZB3Vz9w2ybNVSY8C@google.com>
X-Headers-End: 1pfyHg-002cnT-2R
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: Fix discard bug on zoned block
 devices with 2MiB zone size
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/3/25 0:54, Jaegeuk Kim wrote:
> On 03/24, Chao Yu wrote:
>> On 2023/3/24 6:03, Jaegeuk Kim wrote:
>>> On 03/23, Chao Yu wrote:
>>>> On 2023/3/13 17:48, Yonggil Song wrote:
>>>>> When using f2fs on a zoned block device with 2MiB zone size, IO errors
>>>>> occurs because f2fs tries to write data to a zone that has not been reset.
>>>>>
>>>>> The cause is that f2fs tries to discard multiple zones at once. This is
>>>>> caused by a condition in f2fs_clear_prefree_segments that does not check
>>>>> for zoned block devices when setting the discard range. This leads to
>>>>> invalid reset commands and write pointer mismatches.
>>>>>
>>>>> This patch fixes the zoned block device with 2MiB zone size to reset one
>>>>> zone at a time.
>>>>>
>>>>> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
>>>>> ---
>>>>>     fs/f2fs/segment.c | 3 ++-
>>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>> index acf3d3fa4363..2b6cb6df623b 100644
>>>>> --- a/fs/f2fs/segment.c
>>>>> +++ b/fs/f2fs/segment.c
>>>>> @@ -1953,7 +1953,8 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>>>>>     					(end - 1) <= cpc->trim_end)
>>>>>     				continue;
>>>>> -		if (!f2fs_lfs_mode(sbi) || !__is_large_section(sbi)) {
>>>>> +		if (!f2fs_sb_has_blkzoned(sbi) &&
>>>>
>>>> Could you please add one line comment here for this change?
>>>
>>> This was merged in -dev a while ago. I don't think this would be critical
>>> to rebase it again.
>>
>> Yes, it's not critical, fine to me.
> 
> Added:
> 
> /* Should cover 2MB zoned device for zone-based reset */

Thanks a lot for the change. :)

Thanks,

> 
> So lucky since I had to rebase to fix other patch. :(
> 
> "f2fs: factor out discard_cmd usage from general rb_tree use"
> 
> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Otherwise it looks good to me.
>>>>
>>>> Thanks,
>>>>
>>>>> +		    (!f2fs_lfs_mode(sbi) || !__is_large_section(sbi))) {
>>>>>     			f2fs_issue_discard(sbi, START_BLOCK(sbi, start),
>>>>>     				(end - start) << sbi->log_blocks_per_seg);
>>>>>     			continue;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
