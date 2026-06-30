Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A184C43602
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lkncxQ7Bu+RfJwC1ybf+GK6HZurw4RBoIvtJhscIpAg=; b=kKI3Lb12WDlE8vp5y7EXgK5e7/
	txKfFuVYr5oCgHbepCS+HZKIPQRlvPP/5JmVSr9pJMKlNCYshp6GxVRnaIK99dOGUCr3e3mOgxHtL
	yZ61mJM5Q/G1OkOG2FNv+8Y1tSPpFXRGZQo0jRUx6jnsE2FklpzZtJcoKbNGFIeO6zFE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1weXHV-0005dj-O3;
	Tue, 30 Jun 2026 12:09:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1weXHU-0005dZ-PP
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 12:09:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DvHcNk1NdP2Vtsc0m0nKrmohuP/D6QozrKLzgnXVJjM=; b=dWZbIZXvMafSsh5u5aBmQReAXV
 Yxw4k/7o9DLIL4jAmUsFYXpuXywNm1PmeWDIpiYgGUGBgemfkTzs0Ifru9Sr/Qiv3RL0i1EB9z/wP
 cHU+hPl0gcyvqCnkalisLJdPzBFSE+WHj0fvcyuoEdikVe1s8LjDNak7pLbEiBDFI3p0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DvHcNk1NdP2Vtsc0m0nKrmohuP/D6QozrKLzgnXVJjM=; b=FmGp53jBWHx2rqRI9Uk90F24cD
 6wMypeqSmGdKeMtv93KlkPs4mxZTfm0WJbbS0Blmc3AFJLQuPU5IIrw6jdMOUTU3jp9EuWoFNnkAJ
 lDUf3bTWMX6OMqNShrPIHTbm6OLRKjuQfGWY8OZq5DlbEthUs7C3wMJ+Nkf8fyxah4zw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weXHQ-0004pO-Pt for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 12:09:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A9FD6600BB;
 Tue, 30 Jun 2026 12:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2BC1F000E9;
 Tue, 30 Jun 2026 12:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782821362;
 bh=DvHcNk1NdP2Vtsc0m0nKrmohuP/D6QozrKLzgnXVJjM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=SnVEi9ne4/qQxPRz9gcf2UXRrkNQO5dBIr6cufy1g98cDljoGdpwDebmpWCRHPP9c
 ph9bEXTsQooGZ/MyNNu8dW3W58Mt7/pn7mwHAnNeUrouxwrCdbvX7EwhxeGH4vKeuB
 kMCHOKh0Q80USqf/1ybeAaL8EhQXKbiMq6i9533ZFr+93KYuc37Yfk10b3lV5YOiZ+
 8NVCk9TVcgec9H5eqzVfK4RStXfCY+1+Q9oOE4wfgJk3IHBxDP1w0WIgWC6hrcmMID
 gZSzgRdN7gnuM8qvdyfrU+RuaUg4gY5cxLhsBFem9UMwJbEKLD0bNZlODxkmofH7z8
 NAPNOWJXdJNQQ==
Message-ID: <e7a57c5e-62de-401d-8e39-f7409f398a84@kernel.org>
Date: Tue, 30 Jun 2026 20:09:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christoph Hellwig <hch@infradead.org>, Zorro Lang <zlang@kernel.org>,
 Jan Prusakowski <jprusakowski@google.com>
References: <20260622070438.1542638-1-jprusakowski@google.com>
 <ajuLORVplOvEXvnI@infradead.org> <akKd2IImO7bRjVV2@zlang-mailbox>
Content-Language: en-US
In-Reply-To: <akKd2IImO7bRjVV2@zlang-mailbox>
X-Headers-End: 1weXHQ-0004pO-Pt
Subject: Re: [f2fs-dev] [PATCH] generic/064: allow 50 extents on F2FS after
 fcollapse
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
Cc: jaegeuk@kernel.org, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/30/26 00:37, Zorro Lang via Linux-f2fs-devel wrote:
> On Wed, Jun 24, 2026 at 12:46:01AM -0700, Christoph Hellwig wrote:
>> This sounds odd.  The test allocates a contigous range and then just does
>> insert/collapse on it, which should not lead to any new data block
>> allocations.  Given that the test works fine on zoned XFS and btrfs
>> with strict out of place write policies we know it does not require
>> overwriting blocks to work as well.
>>
>> So I think something is fishy in f2fs if needs to allocate data blocks
>> here.
> 
> I have the same question with Christoph. Shouldn't fcollapse in F2FS just
> remap the metadata instead of allocating new data blocks?

Hi Christoph, Zorro,

Let me explain it briefly, this is because f2fs has only one copy of reverse
mapping table (aka SSA), for any checkpointed data, we can not modify SSA info
directly during remap, otherwise, after sudden power-cut, we will suffer
inconsistent issue in between reverse mapping table and mapping table. So, f2fs
choose to rewrite for any checkpointed data.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
