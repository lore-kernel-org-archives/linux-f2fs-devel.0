Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67D2606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Oct 2026 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AxjXwzCU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kwGpSBb0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=a9VQXQSF;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YXTrvqhP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kC3GyuIq3dbfEHI599IQksIZ4a6RdcO1GpsbBBIbFX8=; b=AxjXwzCU7SJ3TXmyb994TdoKg6
	wPoe2BfYIKx4x8ZxFDVi74d3heAAHrven4KaiM2S4LkrM4YG0eoL48TRxYnTtrCe54ZkgGi0qkreF
	fV3Wj/JfRNx/LIQxFnDlTysB4iFar2zAkHZljnoKH0s3gHdFCZCBHI3lH/SABPRhxY04=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJ5uG-0005Qv-SC;
	Tue, 20 Oct 2026 09:13:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xJ5uE-0005Qo-SI
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 09:13:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mHbpHAKt1bZWR/t1RmAyLv7KC7I2S9cmqXACwiTOa6I=; b=kwGpSBb0JLHZ2ZILKG8QNJqpo8
 DKvQWf3Jf0bh9tJ6xxM8Jfg5FAh0qMxFFWXFiRNnkhAo7w754Hyi6Fs5j5f0b7C0EfUP5M4h2U2tB
 3+BqN6U7FhY6UvXZbdMQAXvUPsvvzQHkcueswO4czlsxWt2VGHrZrbsAW0ROxcj7wA7E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mHbpHAKt1bZWR/t1RmAyLv7KC7I2S9cmqXACwiTOa6I=; b=a9VQXQSFAzaOtMxGCxu+zh9w7e
 4Vj7TFHDDaXE8Q1uFACVvOKGf0yIFaKnMZPMGr4cG6eKwNedWIzN9Bbq/6dDPMeWf8MFJqMvSK4Dp
 PbvFGi5aEkBofMNNyRm1k1dhOutITDAp9E78mPxyNfeR2eWeD0ficDf8aiGgf55a/tiE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xJ5u8-00043a-JA for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 09:13:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 43B1641701;
 Tue, 20 Oct 2026 09:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011AD1F000C6;
 Tue, 20 Oct 2026 09:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792487583;
 bh=mHbpHAKt1bZWR/t1RmAyLv7KC7I2S9cmqXACwiTOa6I=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=YXTrvqhPYIGrkktbxH6stMxHn3CmHz0Ccs0a8ahDfDcHRKVqEdYK7PlwH3hxM9rsd
 CoDjghFDOsdb5CnEpJl89uqgVEmVrGbYhMDMRRohluijFAITzsAD9u8SyLYrc+M9rA
 FX92CSn7fb5/h9Gj4mv6HYt2vyk6cfqJ5ugSZbwXTuoHYG9wcm58H9L+ICHb+csH90
 BUI5HQ3RBuZJWGyEMm5xUhRb7uGrwV9HvUnF23mbWiLeJHSeafHsLnRSv0bYi2nNGG
 IC2kdBv+KCjKSgup8aU++A4x405E/GRCMGFxs/V1jIrYyAiYM2FdcSFp5iOsnmWGuu
 +2++nzBI3TNww==
Message-ID: <18402f96-1c9f-46b2-8ce0-b28e1947e2af@kernel.org>
Date: Tue, 20 Oct 2026 17:13:00 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260911143549.909867-1-daeho43@gmail.com>
 <06bbc322-f0f4-41fa-b645-e5291803506e@kernel.org>
Content-Language: en-US
In-Reply-To: <06bbc322-f0f4-41fa-b645-e5291803506e@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJ5u8-00043a-JA
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: use BIT_ULL for mount option
 bitmasks
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

FYI, in dev, it missed to add my rvb.

On 9/14/26 10:53, Chao Yu wrote:
> On 9/11/26 22:35, Daeho Jeong wrote:
>> From: Daeho Jeong <daehojeong@google.com>
>>
>> Although f2fs_mount_info.opt and f2fs_fs_context.opt_mask are declared as
>> unsigned long long (64 bits), the option bit manipulation macros
>> (clear_opt, set_opt, test_opt) and context helpers (ctx_set_opt,
>> ctx_clear_opt, ctx_test_opt) use BIT(), which expands to (UL(1) << nr).
>>
>> On 32-bit architectures, sizeof(unsigned long) is 32 bits, causing shift
>> count overflow warnings and functional truncation if mount option indices
>> reach or exceed 32.
>>
>> Replace BIT() with BIT_ULL() for mount option bitmasks and helpers.
>> Additionally, introduce ctx_clear_opt_mask() and ctx_test_opt_mask()
>> helpers to avoid open-coded bitwise manipulations on ctx->opt_mask.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202609111633.uyRbsEUB-lkp@intel.com/
>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
