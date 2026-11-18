Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF68606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 Nov 2026 02:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lwQXmp0E;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TAOESp36;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OZMcHFnI;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RzifPs+u
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=K7ADIp/QeJyf2Z6NJCNDeo/+HAoCM/a6CMMbHqNHBUE=; b=lwQXmp0EaROTSF
	1wnCez4s3tO1mA0R6bAe+I9Ag57lLNT+Hgddf+9nt6xnCsbKqxrxugy+dtGbWUMcCCJyE8XMV2TkY
	5C9dB4PCMh68khIhOOyl0O8l/VxhL3S5KI7+3CoryP897koITvrtPsaT5vJ1gLB4QWH9PQCvAIVbO
	/JM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTVRt-000000005iJ-0BSW;
	Wed, 18 Nov 2026 02:31:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xTVRq-000000005hs-3j7D
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 02:30:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qJEhhR5/6tKN8LDHSKveNcLWXyTwd2lpQyvo6+6BPCs=; b=TAOESp36otX7B69bCK0yUWwweT
 blkPMnz+n6SweImGTv6oFv/MQkmZS44y4YtHNWuckbHQqRIvuTj6wLANsHybNMV4ELTAJH/ZBuc1X
 JXxtw8+BSsHMXYMzXkTl9qscithHA2xPQCPjgCvWg/USOcnY/oDbRaPiAh1LMgUbEsBU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qJEhhR5/6tKN8LDHSKveNcLWXyTwd2lpQyvo6+6BPCs=; b=OZMcHFnIrBIsuEiyewUysBhbYK
 cmiXW/9oODIipAsjj1faaN4VfZDOtSsP7TKmav78cneBpVtyfZRaiQYg7yNcCPeZAIsChdW7c7IVc
 vSHLgZCW5Ztdkytm5tEjB2tEEKIrdsxr4jhh87S3mfcoB+14ZYTm7V1hcXmg7CPsqfi0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTVRZ-000000008AQ-2qeB
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 02:30:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 50FFD45900;
 Wed, 18 Nov 2026 02:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092E31F000C4;
 Wed, 18 Nov 2026 02:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794969036;
 bh=qJEhhR5/6tKN8LDHSKveNcLWXyTwd2lpQyvo6+6BPCs=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=RzifPs+ueb3I337mdPVbWjVOFU3xOKzzDV0AgrLMSU+WKEqoaKrf6ETrTYUt3tXAc
 2mOQlKwikjBtMhZ/MW8nPnPGCbjWWz1Vla1TsKhkIQWNGWF7uTY2z6ON/dXeXsJY0E
 R2DiTIPcRhyE1OcqnunOTdS1sVzHXzKzM9msp3Qs27PvWxhea3nyR8IkD6MuuY3qcT
 ZHi18C3uskU9gUESPSa4/IZyPDTbR4qdGBzbL81qwS4XSZVg507oCJhfU5E75g86+y
 N5lwU6F5hnBQmxAn0YSNFEaLX4JaBlJ/MXmdSYvUKdle2S932HwR5TwoiCr105EqJ3
 3LLISeH1gPbgA==
Message-ID: <f5c7a29a-d751-4db1-a054-22e31386c3a8@kernel.org>
Date: Wed, 18 Nov 2026 10:30:33 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261116040851.2849696-1-daeho43@gmail.com>
 <20261116040851.2849696-20-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261116040851.2849696-20-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTVRZ-000000008AQ-2qeB
Subject: Re: [f2fs-dev] [PATCH v2 19/20] f2fs: count compress cache entries
 in pages for its memory limit
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 12:08, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> The compress cache holds one filesystem block per entry, but
> f2fs_available_free_memory() compares the number of entries with a
> percentage of free memory counted in pages. With subpage blocks, this
> limits the compress cache to a fraction (block size / PAGE_SIZE) of
> the memory that compress_percent allows. Convert the entry count to
> pages before the comparison.
> 
> No functional change when the block size equals PAGE_SIZE.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
