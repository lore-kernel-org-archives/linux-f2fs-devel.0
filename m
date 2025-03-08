Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D82C28B28
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  8 Mar 2025 09:56:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tqqvE-0001ym-Ts;
	Sat, 08 Mar 2025 09:56:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tqqvD-0001yg-Fy
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 08 Mar 2025 09:56:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CUH4dDLzT6GtaDsv/fiGFSgDZHjCAeg1TiqX8dahLJs=; b=SjHZixN6rHKgmSMoFeoqcrT3+J
 VuAQaNwXn9Dp8aza//G0u5jlIW/JI9TkTBbu4bRjzMffqRzWjvukbjo6NW+AeiFeFbpcEVoRAkjEt
 Nr6SDx5YFxPFXpMP5K8+DV+Ifx4dPdzThgLdG082XiorCHdxVuamzUCYydRxIaEijgac=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CUH4dDLzT6GtaDsv/fiGFSgDZHjCAeg1TiqX8dahLJs=; b=QkaPyEEUvOs46O/Mh+yQm5mjjG
 SaO/ZQeKIdjxNYOHzxUAHHlSgu9GphAQfA9nhTDWfxIKxwjnz53gqZmM68hB/pkMSe/BxxrWGo3ho
 /hT8Rdji3S+3JFGO6jv5mOcyYyj2yVn6wpvtXR1assDgwENgO1Wf1X24QtdbjvKfI6hc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tqqv1-0000df-PM for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 08 Mar 2025 09:56:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 89D565C5598
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat,  8 Mar 2025 09:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22788C4CEE0;
 Sat,  8 Mar 2025 09:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741427781;
 bh=60XBRM5aenNPXo3XHWO87rpYBuXDMcswRuEPm9TqGE4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=AK//zFk7TzNhTPApiVSBFzhf1Xu4kSHH8GNMi1tuLKDYnRagedy3SfCl/n4vp9/aA
 LYPGdytkFoAwQYYg+JYY+0wzCG+RnnQ8NgoBgNikVzetRIl7n/NtEttTI+u9iC7MJ0
 0+h1AISHybOULmTG5BdUja8H8YiX57FXHGMw7Rv9teB2G9UlH37JR5El9dxZivny76
 0ajJKCiGBdnugbbGOPneOwGjG6hD8i4+z8LtDKpTgcOguvn68fBYD/3ya1jJo5Q68T
 X9vDKr0hbcOpvKTAB0/H8nN9XZOEa2UyRvffz4uC4yYNzoHDWC1mcmwVoPuK7MhM/E
 l2JgGX85UA5cQ==
Message-ID: <adbc8517-95c5-41cd-b654-79f1ad7ab58c@kernel.org>
Date: Sat, 8 Mar 2025 17:56:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250307031838.19164-1-chao@kernel.org>
 <Z8s2rmqauwCGJb9v@google.com>
Content-Language: en-US
In-Reply-To: <Z8s2rmqauwCGJb9v@google.com>
X-Headers-End: 1tqqv1-0000df-PM
Subject: Re: [f2fs-dev] [PATCH] f2fs: disalbe nat_bits by default
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2025/3/8 2:10, Jaegeuk Kim wrote:
> I meant let's support it conservatively if someone needs to enable
> in other platform.

Oh, I've updated it, we can control it via mount option now.

Thanks,

> 
> On 03/07, Chao Yu wrote:
>> Let's disable nat_bits by default.
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/node.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index 56873c41436e..3148d9e44e7f 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -3286,6 +3286,9 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
>>   	if (!nm_i->nat_bitmap)
>>   		return -ENOMEM;
>>   
>> +	/* disable nat_bits feature by default */
>> +	disable_nat_bits(sbi, true);
>> +
>>   	err = __get_nat_bitmaps(sbi);
>>   	if (err)
>>   		return err;
>> -- 
>> 2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
