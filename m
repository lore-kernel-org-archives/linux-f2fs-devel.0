Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7C9CAC597
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Sep 2025 08:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xm6sjkKhoh5vUWmfs9zg1vkRycrbh1PkUbMfi+rkv/M=; b=TLFGJHsHT4p5CJWEzzJWz2XS0c
	C9Ceq8txszXJWXwu1A2HeFvEAeYRccsmyeDgr05yM3oHBzzMOUq0qHtjgKvmCQN23jk4lZHN1XyDG
	Va52WOuEI4sI4SgmWT6KWar4xAL7exXv04TwgJsbI8rWmaWLRdCq0wIAepfK4QuyjGAk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uy4Wn-0004cU-Pj;
	Mon, 15 Sep 2025 08:25:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uy4WX-0004a3-7J
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Sep 2025 08:25:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y/ZhZLzbps5o5RjrNnGC92nz5MK10up4ZjSkP61JKLQ=; b=KlWLLOL2MWnO+p9ObSK6hVElKe
 5ZK0gQj5lxS3RIwuzKahdtGHjJLDBGWjeBfehtckqeOAU2U5eTADOI2AkUrJxSyQPc3QXuU3QRpS2
 nDnFPzdM4/9j7nfOAIVYqnIXxiGgeXczjAH5/zNpuc/HkjC2JC7eksgk61NiLjgOrgZE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Y/ZhZLzbps5o5RjrNnGC92nz5MK10up4ZjSkP61JKLQ=; b=jMvh9NS/fv3Mz0j6xXSJruLe3U
 3mZeFxAlEDDNmYH7WA564FNoy3mZxYO505GV5p5JSjDjKhcYaFkpcrRI/8OBoqStAmRPzCr3qYnrc
 M9kPmy/ky/JqFu2DEGjPf4X27zkFe30rleG8KLTg0srts4kNJaIxwMZ2CjtdgIWFjYpI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uy4WW-00009z-Sk for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Sep 2025 08:25:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C5F743538;
 Mon, 15 Sep 2025 08:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC15C4CEF1;
 Mon, 15 Sep 2025 08:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757924710;
 bh=J7tpPuV+eu02Wd4vHkG+u41CnXzWALqKvv+0+85N7jg=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=LbV99TcNDiJOWtXsPZdWdsnLmEkMFqtKJ4FyvOIP5yMT08pGCpAjOTiXYDNGg7dTo
 e+L/z8Yq1mueYryYJPYWdhE3K+Toej22KGENrcNjOwT/Tz7eGUDdJqYxjn+K4rASv0
 O2T1LDZWoTuyYfGRfj8+URZiWrdE2jLF//1Tf3zQ3ffCgPnNvGj6QtKXRbCj3oqFmA
 l6EgmYTB8sCIgwTZCmGHf2gxt83qmnwKcvS1rXQGgbf1F33h6i6ARW40gX91/dxz++
 OZoym5Rxzr7/7h4yGnbbz/5BhFyU1TAMv5WomcWEQBPia2JEx+Uk9aH5yTz+SyR1J2
 mRyjooT/Mb74w==
Message-ID: <759bf645-6460-4d0c-a7c8-4cf40eb80a3a@kernel.org>
Date: Mon, 15 Sep 2025 16:25:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 open list <linux-kernel@vger.kernel.org>
References: <20250909134418.502922-1-liaoyuanhong@vivo.com>
 <20250909134418.502922-2-liaoyuanhong@vivo.com>
Content-Language: en-US
In-Reply-To: <20250909134418.502922-2-liaoyuanhong@vivo.com>
X-Headers-End: 1uy4WW-00009z-Sk
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: Optimize excessive write
 operations caused by continuous background garbage collection in Zoned UFS
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/9/25 21:44, Liao Yuanhong wrote:
> Incorporate a check using has_enough_dirty_blocks() to prevent redundant
> background GC in Zoned UFS. When there are insufficient dirty segments,
> continuous execution of background GC should be avoided, as it results in
> unnecessary write operations and impacts device lifespan. The initial
> threshold is set to 3 * section size (since f2fs data uses three write
> pointers).
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
