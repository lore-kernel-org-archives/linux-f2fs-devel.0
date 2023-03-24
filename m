Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (unknown [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AE3C74A5B
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Mar 2023 01:52:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pfWbn-000645-IG;
	Fri, 24 Mar 2023 01:52:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pfWbm-00063z-7h
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Mar 2023 01:52:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8cSqDpNgtrTK6/DVDh/DqIWgX0nq/uJWGjnbYsenW7Q=; b=m7BUlYMdJG5BMYKB0AQNWtJckC
 bYZ5jSkTpwXzwKGBrYzNUg9Jkvm8gSeAXGz4VY/DiopzUNDnlGKLa1ncO3aLG11GRlpJjXVMevzv6
 tQTHCSMzACv+gdkBWRKjWNQkgFtfQDZnqn2WQybA7aLv8HxVpDKlSG4jdGFkdAJbzKu0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8cSqDpNgtrTK6/DVDh/DqIWgX0nq/uJWGjnbYsenW7Q=; b=TMLA3bV4lLiqEYdxnkc2MFpLT+
 pr64qMTmI2jgzUgkhxF2z3Pz9JOj8zO6Yb6m9ZWiOBCueG24tiOSGH1Ftv2KAtdFiSASeCvwwb30d
 zi0BTw1Vz45H8gucu+Id41xZ+zSOwOeN53OSJ5p6o5NvWP/X9Th1RrWZmcDGohqNd6/s=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pfWbl-000v8s-TP for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Mar 2023 01:52:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2024FB822B1;
 Fri, 24 Mar 2023 01:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1FFC433D2;
 Fri, 24 Mar 2023 01:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1679622748;
 bh=7Ov5bcBJRytUEv+2NcWM9mM0KBzimX69aeySA71KuQQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ULPZ1Hb5Fx37otUY1CFhOilyXzeSeno+3EKAk+3D0advy9ZCTEGh9FiBfvXlRoxZJ
 EUzg/uvG6IDzVqDVnfeCe4TC0WoWELgL8ErWr1/xokXizv0YWca81VMVQhUwCdDBUj
 nEJxbb3rzHeyqYndELjP1dnDFtFGbtE8dpfUl6segz4dmJO6D6t69AXvfhrh9ZX+xd
 YMkTHuh/SK7f4kKJCu7hxXoUeVXoaTb8uNco/p52C6yAvXfD/waEaDNcCEPGeJ0JuX
 DpmMs2GpNNA4IsNtGPwC+GvxLbDVClC05suMJWEEprCFkSNViy6QgarmIY915Gv7+U
 P6QfpgjXL7d4g==
Message-ID: <35dd1eea-f1b9-418e-5f97-cfd10b7ff803@kernel.org>
Date: Fri, 24 Mar 2023 09:52:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <CGME20230313094825epcms2p71e6cb549251dc55e8d202dd64b9913a6@epcms2p7>
 <20230313094825epcms2p71e6cb549251dc55e8d202dd64b9913a6@epcms2p7>
 <a24d66ad-4048-fd5c-ae47-2dd17c87bcbe@kernel.org>
 <ZBzMql6DkrUWiRKP@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZBzMql6DkrUWiRKP@google.com>
X-Headers-End: 1pfWbl-000v8s-TP
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

On 2023/3/24 6:03, Jaegeuk Kim wrote:
> On 03/23, Chao Yu wrote:
>> On 2023/3/13 17:48, Yonggil Song wrote:
>>> When using f2fs on a zoned block device with 2MiB zone size, IO errors
>>> occurs because f2fs tries to write data to a zone that has not been reset.
>>>
>>> The cause is that f2fs tries to discard multiple zones at once. This is
>>> caused by a condition in f2fs_clear_prefree_segments that does not check
>>> for zoned block devices when setting the discard range. This leads to
>>> invalid reset commands and write pointer mismatches.
>>>
>>> This patch fixes the zoned block device with 2MiB zone size to reset one
>>> zone at a time.
>>>
>>> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
>>> ---
>>>    fs/f2fs/segment.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index acf3d3fa4363..2b6cb6df623b 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -1953,7 +1953,8 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>>>    					(end - 1) <= cpc->trim_end)
>>>    				continue;
>>> -		if (!f2fs_lfs_mode(sbi) || !__is_large_section(sbi)) {
>>> +		if (!f2fs_sb_has_blkzoned(sbi) &&
>>
>> Could you please add one line comment here for this change?
> 
> This was merged in -dev a while ago. I don't think this would be critical
> to rebase it again.

Yes, it's not critical, fine to me.

Thanks,

> 
>>
>> Otherwise it looks good to me.
>>
>> Thanks,
>>
>>> +		    (!f2fs_lfs_mode(sbi) || !__is_large_section(sbi))) {
>>>    			f2fs_issue_discard(sbi, START_BLOCK(sbi, start),
>>>    				(end - start) << sbi->log_blocks_per_seg);
>>>    			continue;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
