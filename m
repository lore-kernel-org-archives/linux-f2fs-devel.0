Return-Path: <SRS0=cCFG=M3=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C28C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Aug 2021 07:41:48 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6CFF60F14;
	Wed,  4 Aug 2021 07:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E6CFF60F14
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mBBX9-0003j8-Aw; Wed, 04 Aug 2021 07:41:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mBBWv-0003hu-Rr
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 Aug 2021 07:41:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q4L4oPFEGp0M1e+BQjfwv1/Oh570inQ9g0pLlqjXNpY=; b=kImMvK0SRXMAItV4miQs+TXGAm
 2sML6OwVIvLK2YPycKUVDmMrIbwfodRll7QdJLqDe3b36isr4d4pt59OqzFsq5xZeK1xN4Eh+zLTU
 77LoEJSRR155pfUn4UIukh1Yv5dBmgVVWjKr/Kkqdf0+Kxi0bIaFA7HH9+u/Ob+Mz4hc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Q4L4oPFEGp0M1e+BQjfwv1/Oh570inQ9g0pLlqjXNpY=; b=IGypz+UYwNEPK/NW6z53/FPga/
 Gtzhsl8oD51ZdiYAb9yhNzIcCTNCkUF0uIutJq84KKzgrGz8Zp7Fg9OsGI2xgCIQGVGR1e5wFlgqf
 riA1sRrTWj9MV3JlNKNu3KJTMwBWqahU8w+DL0t2vf9QM+Jt2z3odjuLeuKK4UCYvS78=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mBBWs-0003gC-88
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 Aug 2021 07:41:33 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id D80B860BD3;
 Wed,  4 Aug 2021 07:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628062879;
 bh=Pm6fYyTmBfc6cqn8GdKXA+qPcfd/g6gN0afm3nZoctg=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=JL7zGSXgQcWrdXFmQXVBEIe74njilMYnBBrxniUqQurLN/tNbmRd6Zfg9zZ7h+gjy
 v4jDPZhEIZnY8OzhV6p4GW7Key2mXWJgFXxEv/ExTi0SIaw0ORRc5Zl+5ynfEaJdrY
 856n5kfKoTHqS6rh12U18VVa9nmBoBNLTQqJOyLoBLf4KOHXMCjiRqwjKX4hmRpSge
 KfugJAzjTAydSrtYgS04hn1kc81d26/FgQi/2FWqleVGF2VRqUTUIQ/unDOCIrYX3N
 i1xKfK8diXXcOQojmOKvvoOAsvJpGYTNiW7ZyOoeG5c3CM8NTcBZ14eQlWUnnluI4f
 W//MzhI8+G8cQ==
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20210803023912.26667-1-chao@kernel.org>
 <YQnzJojWyVrNf9op@google.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <2cd44682-4e50-24c0-0f56-5f6aaf827e48@kernel.org>
Date: Wed, 4 Aug 2021 15:41:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQnzJojWyVrNf9op@google.com>
Content-Language: en-US
X-Headers-End: 1mBBWs-0003gC-88
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

On 2021/8/4 9:53, Jaegeuk Kim wrote:
>> +#ifdef CONFIG_F2FS_FS_COMPRESSION
> 
> Can remove this by if (unaligned)?
> 
>> +	if (unaligned)
>> +		en->plen = ((struct extent_info_unaligned *)ei)->plen;

struct extent_info_unaligned should be covered by CONFIG_F2FS_FS_COMPRESSION.

>>   static inline bool __is_extent_mergeable(struct extent_info *back,
>> -						struct extent_info *front)
>> +				struct extent_info *front, bool unaligned)
>>   {
>> +#ifdef CONFIG_F2FS_FS_COMPRESSION
> 
> This can be controlled by "bool unaligned"?

Ditto,

> 
>> +	struct extent_info_unaligned *be = (struct extent_info_unaligned *)back;
>> +	struct extent_info_unaligned *fe = (struct extent_info_unaligned *)front;
>> +
>> +	if (unaligned && (be->ei.len != be->plen || fe->ei.len != fe->plen))
>> +		return false;
>> +#endif

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
