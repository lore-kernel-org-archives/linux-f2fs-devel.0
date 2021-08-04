Return-Path: <SRS0=cCFG=M3=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3154CC4320A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Aug 2021 00:55:14 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB66660E96;
	Wed,  4 Aug 2021 00:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EB66660E96
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mB5Bg-0003z0-VC; Wed, 04 Aug 2021 00:55:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1mB5Be-0003ys-V9
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 Aug 2021 00:55:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lig83yMROpldhT56dxWJOgRXz4qsa5VlbJuXK3aImBU=; b=EOgl15dWLH7kW6Uu22rtqhYVG7
 +HOHFatM1DhxTH2mGYy/ek/+Qo4QH9ozI+9pbK3S+vGARMEUYeGWyE9/SmsaaFuGPmt2UpLkBJ51Y
 QTN6lY9Okk71IEB7MVWTE0t7CgnTjMxjopCWWCSbew4W+Hs940e3fyI8BT7RJYZIA5XM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Lig83yMROpldhT56dxWJOgRXz4qsa5VlbJuXK3aImBU=; b=e+bIwaB8/j+xepFcd509C8eLjp
 dcFT2dK736esDg3WCoMZLV6GGzBD406JVjEKGMbhpojErK6NBEpd1GldZB7/M4a13magZzKRzpNpe
 yWvgnf03A89RVFgSpogMnxp6y8iumD7MsWPgndDlqiHtlOm1tuFaPZEYzzkyxuxnUlj4=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mB5Ba-0004g7-SF
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 Aug 2021 00:55:10 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D76560EFD;
 Wed,  4 Aug 2021 00:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628038501;
 bh=aJH3kOdf8qd5RXoedFR4M2Cq1LOGvclWPP+/896MrNs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=S/6vQY8ThuIEr1Lq8yWPTcCQwrgF2wLQbzHS/JYyCzDSpWnvScsdx07CnoG3uflZJ
 j5KPw3Q0pA4JfGi031sivlece5NjCmXAqwTp2quXcrIiNNxlwMQg9h2mN3oCEnXyAg
 sUgvZ9I3d7JOlfBKuKkIc+4x8WgDggE0FxUh0P5CeI75Jx/53ADY/iXwO+WRkVp+rc
 JqYk8eJOexrzENIgxdVNMY5FZhej1xfyGC2601FKlddg1DiOiPisTE3EJWFP3q+RHz
 F8SCAHdiFNEJEMXNGEAtHHfVI/UtIReuKXWzL0FkmCvaA5DiJPa6rs9FdW/Q4/KYbf
 s3QPWyKpnNLGQ==
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20210803023912.26667-1-chao@kernel.org>
 <YQmNzBofsqv/zEdb@google.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <d08ada1d-b0a3-6ed8-449b-10bf2518f5ba@kernel.org>
Date: Wed, 4 Aug 2021 08:55:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQmNzBofsqv/zEdb@google.com>
Content-Language: en-US
X-Headers-End: 1mB5Ba-0004g7-SF
Subject: Re: [f2fs-dev] [RFC v2] f2fs: extent cache: support unaligned extent
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

On 2021/8/4 2:41, Jaegeuk Kim wrote:
>> @@ -247,6 +247,11 @@ static struct extent_node *__attach_extent_node(struct f2fs_sb_info *sbi,
>>   	INIT_LIST_HEAD(&en->list);
>>   	en->et = et;
>>   
>> +#ifdef CONFIG_F2FS_FS_COMPRESSION
> 
> Can we avoid the above ifdef?

What do you mean by "avoid", getting rid of CONFIG_F2FS_FS_COMPRESSION directly?
or wrapping codes into function and define as below?

#ifdef CONFIG_F2FS_FS_COMPRESSION
void foo() { implementation here }
#else
void foot() {}
#endif

>>   static inline bool __is_extent_mergeable(struct extent_info *back,
>> -						struct extent_info *front)
>> +				struct extent_info *front, bool unaligned)
>>   {
>> +#ifdef CONFIG_F2FS_FS_COMPRESSION
> 
> Can we avoid this ifdef?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
