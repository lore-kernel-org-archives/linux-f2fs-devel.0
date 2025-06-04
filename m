Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDA0C5AD49
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Jun 2025 02:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7sOw1WQ6BcSg1OHXkRHspKUhF6+iIF4/OmxqV3xDWLY=; b=YJf/f0xcHgwVzpIP5MTSJb3rCs
	PtKhAUALPvXpoalqDHE3sEBvEHAIZxa+1ZWVm+N3Z06MVfSM6+BDPVvJ35OMF4hJiV8rGTbddYVqc
	hNqoHvccUfAu8qVE5q/7MQsR1OX3B2zb8rKLPDO9RbWMaIMsD/UtvqhTzvia7eX8Y/YU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uMdZF-0004K9-8a;
	Wed, 04 Jun 2025 02:09:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uMdZC-0004K3-9Q
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Jun 2025 02:09:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8jmoKCOfrVjOYlqaGSvHzdFFI64xJgpnKuU+5oiCsdc=; b=Q37AeMjtVpG/7iNhZQ2JdrE674
 E5ic1AhEoyH4wE17pN5TvhxoXKrTAAEufKDfE2b1BGt5fDBFbjgGTsHtmE1sXj0zfvh3ZIdT2B0m8
 3tLz3FUyHkWJS6IIYqtHm92hbzTc6XqZQMU5QBzy9QdXzS3GXVrtMUEIon8Xel97tui4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8jmoKCOfrVjOYlqaGSvHzdFFI64xJgpnKuU+5oiCsdc=; b=AIxeq3DqCPoeczB88Rl6ANz3+N
 ZyNoEy4koIb2oRH20NG36XRwGniTxahOzqOkmb4v1dtGcDEvTXKfdAhGJXVwTRv1HAKiV6U7SPzaK
 HE2MWi0+ZvdmAQS3Bg9TiBeI9Zf3ZivrogmQx+SAPdoK/kPAwGClkXAud8RBMDDq31A8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uMdZB-0003vL-MY for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Jun 2025 02:09:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 144FC6112E;
 Wed,  4 Jun 2025 02:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE5BC4CEED;
 Wed,  4 Jun 2025 02:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749002955;
 bh=YzOZh8AU2L5eg3A4Z0bzNE9hBsb4+8Qy9LP6iIx6rKU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=rR6CjxxvAdGTZ8al0GLUgz9uC/PkVMDZE676J1IzwhZ0w5uqsCrnLI2X5vpA35Vwt
 RqemeqQtY3F6qMIqaigiYXccWWAP2+XApmexHtIou2THej1EdCVM764/OTvvF4+Hyx
 5E73IBl/tCGN9ifZkt/S6WnvENzU4rMW6qjpbEIAsvLPG5trz1+b+8vmtiZTi/lFuQ
 Ip01Ap0Vc3XlZHo5bVM4YVRie1mJ5zqnaW0grBXda+NhDoeb3DxME+4iJGqFA84TmI
 L1sV9vWs+HoBk42u++1tQfmzpW7NxmFzRigrjzzSaICWo4Q6pkeVccqne5X6DVfKGa
 YMgHRnHuhf7XA==
Message-ID: <193abd7f-560c-4e07-93d5-0d75eb0cd262@kernel.org>
Date: Wed, 4 Jun 2025 10:09:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20250603173739.2483532-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20250603173739.2483532-1-daeho43@gmail.com>
X-Headers-End: 1uMdZB-0003vL-MY
Subject: Re: [f2fs-dev] [PATCH] f2fs: turn off one_time when forcibly set to
 foreground GC
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/4/25 01:37, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> one_time mode is only for background GC. So, we need to set it back to
> false when foreground GC is enforced.
> 

Nitpick, let's add fixes line before SOB as usual.

Fixes: 9748c2ddea4a ("f2fs: do FG_GC when GC boosting is required for zoned devices")

> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Fixes: 9748c2ddea4a ("f2fs: do FG_GC when GC boosting is required for zoned devices")

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
