Return-Path: <SRS0=FIBF=NP=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD4BC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Aug 2021 23:35:50 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F4E61183;
	Tue, 24 Aug 2021 23:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 13F4E61183
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mIfxN-0000a5-9b; Tue, 24 Aug 2021 23:35:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1mIfxL-0000Zt-Bm
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Aug 2021 23:35:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MHiIl+s0jgnoQOB/PYq1mrWodylRXWxCj/sxy9Vjjug=; b=f7rcZ0CNzwNRobmSOOpMoC5Yp5
 ejQsCDXw+tiYF2yk7MVaugtfYtUj0OKEi2fEnnDhji0tC9tlC+WrXvKZUN7MPMKmNoaTeMypVBC2S
 DwykNX0cXiDXO2SkJ6eYTD2vb6GausDw0DULPGv5jI5xFJbEgtGJa+31FmFxpnltY4Gg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MHiIl+s0jgnoQOB/PYq1mrWodylRXWxCj/sxy9Vjjug=; b=Ij0ozXSyqMytL2cnMhLa9Ceh3c
 wOMzHFnrulAxhhOYNDhPypH90lnJPoIyukWHGvhAIN9FA5FuOfwcohlVFeU3Xi+IxS8h6xgSWVUjU
 OXSATXoxV2v6pq8I0gN8Ac9OWdJ98ipPjmr2pVZ0qe7PEVojwbdS/HzKZIgqMCrNpGkg=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mIfxJ-0007qt-KE
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Aug 2021 23:35:47 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 842C261101;
 Tue, 24 Aug 2021 23:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629848135;
 bh=TmmmCy3ttRTPrwcFEXqnLiJzYlTQBbSyZZokMksdh6k=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Xa5ffoXsFfxhlL30GG+vlyO9U4ExCvHxDy3AoC5wlWqluFeDCgQHKS36MWFQ56jXT
 BuuB1dJ0va2BlhoHRFV6WCYVGLi4ti6P3ct0fK6nkmJVUgteaC1dxWbZCBU3Ve1AAb
 URsvWYx9ZRP5DK6KL76/uxZ1F6TKIKf3r8WppEZE4H3PAD/vH/Y7nSnii/cEVRvKtW
 aQ3tCjlsW4Srh4+JD3slxikZUXhuD0bDPXQTQuYYxt3QlpSOnGZVsnnz2NrogkCISD
 BBtkT1JUx2VZMtw+CMukdigpldZvGfQ/W5yXg1U6qZtbYtbV2MLVxTFi33/fC30uSN
 YQtL/bPT6T2oQ==
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20210824011948.15408-1-chao@kernel.org>
 <YSUr1GS0M7weoRTt@google.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <2520fdb0-835f-2664-198b-386416464e0d@kernel.org>
Date: Wed, 25 Aug 2021 07:35:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSUr1GS0M7weoRTt@google.com>
Content-Language: en-US
X-Headers-End: 1mIfxJ-0007qt-KE
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix wrong option name printed by
 parse_options()
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
Cc: Chao Yu <chao.yu@linux.dev>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/8/25 1:26, Jaegeuk Kim wrote:
> On 08/24, Chao Yu wrote:
>> It prints below kernel message during mounting w/ checkpoint=disable
>> option:
>>
>> "F2FS-fs (pmem0): checkpoint=merge cannot be used with checkpoint=disable"
>>
>> Fix typo "checkpoint=merge" w/ "checkpoint_merge"
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/super.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 49e153fd8183..88c66e46bd5c 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1289,6 +1289,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>>   		return -EINVAL;
>>   	}
>>   
>> +	if (test_opt(sbi, DISABLE_CHECKPOINT) &&
>> +			test_opt(sbi, MERGE_CHECKPOINT)) {
>> +		f2fs_err(sbi, "checkpoint_merge cannot be used with checkpoint=disable\n");
>> +		return -EINVAL;
> 
> What about disabling MERGE_CHECKPOINT autmatically?

checkpoint_merge was introduced separately rather than adding a new "merge"
parameter in mount option "checkpoint=%s", so they are compatible.

Please ignore this patch...

Thanks,

> 
>> +	}
>> +
>>   	/* Not pass down write hints if the number of active logs is lesser
>>   	 * than NR_CURSEG_PERSIST_TYPE.
>>   	 */
>> -- 
>> 2.32.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
