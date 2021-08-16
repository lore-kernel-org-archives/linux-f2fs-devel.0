Return-Path: <SRS0=ksoz=NH=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29C5C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Aug 2021 07:43:49 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A851961ACF;
	Mon, 16 Aug 2021 07:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A851961ACF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mFXHg-0008Tc-Vg; Mon, 16 Aug 2021 07:43:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mFXHf-0008TR-1E
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 Aug 2021 07:43:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s+63QJ05dtCVukhGva5F/UPrKhdv+C6Z4TSULz1aydM=; b=NKdGDHr2mBxMyMlXtUOmW3tf8g
 HOtU5uT3sd2m29MlKDbN9PGuBVGISknJhut15hni6RmyZnCnIHpKG1SE8rECGbbq86Y3WXXaGJrPK
 rVf5lUrxBau1uTv/AYDdtau6WJfxJcl4H27T2/s42Mc5Nis9qprqt7GSU2C7Fa0/IeoQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=s+63QJ05dtCVukhGva5F/UPrKhdv+C6Z4TSULz1aydM=; b=JDp5cHFMtWC9j6Yu/IyKyLYjml
 t+9Uf6bA6C5q6QmneOCqZy39vK67SJ4wU6+/1mk3I61iksLW+93b04up3c9CF6/UK69f2MT0dRXPQ
 NFNW3fyiSHrOuD+42P+IAFHSrZdNbqGQjmjnhK3hmtgecoVRR7PcqIOh/4XeAbsIJaZA=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mFXHd-0003A8-7A
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 Aug 2021 07:43:46 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA1C761ACF;
 Mon, 16 Aug 2021 07:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629099819;
 bh=U/7WQDfo/Qzy9+DjcIIAqHhrpYiE7FohGVxSzIJvDVo=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=h8CnmTOXZnIpGStqbefpN8NqUfXS02jg7aHR4K+eppyHbzr+9JN/t2BYf/EykzQQe
 zvQr0wbG/MTqFl3mXTzk5Z4ofW7x010aZFcYRoOfJvWWztgAm6e5Z2gAhoDOInhA/6
 8SF6A9eA5QMGMs3QBPWL+MeRocZu4bX6UOR62fx/EUK/zvEa/MiXHa0rL3xUPzM+Nm
 o4419Beq4E4sVz7YDZ0CpAE4o0Y/OaD3Ij0Yf7ByapyFK3KkjjTFZDcST9skepALrR
 yc1T3dhg8CMVanxf/smyUOMzTMvD77u40/gK8mCQBKf7w64AfOwDT/0KsgwoFzHrLK
 2KP3sM1FUyK+g==
To: Daeho Jeong <daeho43@gmail.com>
References: <20210809185449.2565768-1-daeho43@gmail.com>
 <425daf77-8020-26ce-dc9f-019d9a881b78@kernel.org>
 <CACOAw_xTh_HZizaVzDNjnVswu_OQwOjzEWRNxouGtM9E5qj6Pg@mail.gmail.com>
 <071534dd-cf10-38d3-b83b-c833f9c0a70a@kernel.org>
 <CACOAw_ye4y-njHbewXsvVr3gTT4URsw7VH4HM_D_g=zntwjtdA@mail.gmail.com>
 <dc21e445-126d-ef74-3d09-c5a71782ed2a@kernel.org>
 <CACOAw_x1F6Uu3p9RA8S7XBXnEYsnjPFY0JSG_VqBLrUjqAGeCA@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <50bfbeee-e165-5bcf-1c47-a45ef8b36ebf@kernel.org>
Date: Mon, 16 Aug 2021 15:43:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACOAw_x1F6Uu3p9RA8S7XBXnEYsnjPFY0JSG_VqBLrUjqAGeCA@mail.gmail.com>
Content-Language: en-US
X-Headers-End: 1mFXHd-0003A8-7A
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce blk_alloc_mode mount
 option
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/8/16 15:11, Daeho Jeong wrote:
> I agree with you. But still I think "fragment" mode should work even
> in low free space conditions.
> Otherwise, it will be seeking the free blocks again and again like a busy loop.
> Or we can change the block allocation way into adaptive mode under low
> free space even staying in "fragment" mode.

I think fallbacking to adaptive mode sounds good to me, so the condition
of fallback may be there is no more free segments?

Thanks,

> 
> If we can handle this, we might use "fragment" mode for both
> simulating after fragmentation and making the filesystem fragmented.
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
