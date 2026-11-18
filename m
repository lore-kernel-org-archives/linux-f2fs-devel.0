Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31581606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 Nov 2026 02:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NoA5ItlR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=apOOgcPZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=W7jafnfg;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXYk8RVi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=xGkvN1LTrXiQwhXMd/7heAmmCnDlXz9fLWRVd+KVlkE=; b=NoA5ItlRjTPDhQ
	4V617RDrvCzg5dj4r4T2gQ8zEaFeaW7DLVzy0lVJddb/xkokLFObbyp9SBoO1vCKrcu83xY7+obzE
	79HrUiHSxMmjcCPRiTUX3TraOzzkFf5TuSsAQ26BbGMvVfWPCfiQVKR4DaTXighLjI9bROoVTaO3M
	5v8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTVRq-000000000tI-3qDi;
	Wed, 18 Nov 2026 02:30:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xTVRn-000000000t5-1A5f
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 02:30:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CPr3svibvd1U4dcTkD14lyr1VGsTvkn2BSMaTJqGAD8=; b=apOOgcPZOWBj4abCwJOpTYoTxd
 E1eP6hr3p4A+OvQlYRSqIyKHd0MNOGSUEYQZpkJ446M04WGjxRH7I1CC42gAlD+k25t8fj0zRUBgP
 cYdpwXg/BmQwfZSAPajWpgO9zVyxnlb6jOeyu/VDoHF2JEZ3qyopS2TS7dMd51RVU8E0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CPr3svibvd1U4dcTkD14lyr1VGsTvkn2BSMaTJqGAD8=; b=W7jafnfgmxrIGQ1DPu3SD5AJvE
 ZNFB7iDxyuzr5emB+XMZMEDbpKw6xPMz0PtiR93044nbozCfCk+5EIH4dv4hZkCH1IhU04Di2BtUt
 zbBwO9GnbBTcyWkNXxNyxqCidWdPzSlbrXRK45zV9dMRsdW4ih9/7ZEN3dSLFzeNbaf0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTVRm-000000002xd-2tdF
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 02:30:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5EBB340C1B;
 Wed, 18 Nov 2026 02:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1588E1F000C4;
 Wed, 18 Nov 2026 02:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794969049;
 bh=CPr3svibvd1U4dcTkD14lyr1VGsTvkn2BSMaTJqGAD8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=MXYk8RViH8fua0hsxtSnRRLBCccNLckeoap1Koo3tJ84rjwecP6dTZQgJKarK5B6C
 Bc4NOYFkKmZNDPdz6Mz++WzoVGFLpvvUqvx4eQC9WfHQx/Bgh1Y59rlaQogpZ5x7To
 olBuoiz2lCvpiJVj4g6yFwRO0j9jP5CufFKhSeEjaSnZmhohUB/drebJ0BjtxYpBfa
 LBeA+gInSR9XooFl25riEbKJMbqF98LOdIhwWzCqkJKyZINBCdY7xFEraU4PqdiiZ7
 NXbSg9wNnGKYfJVhxwZdNBVAbtHGEieHc/rFOqxtTYPuTNbWKYFU54US8J2dBPJnmv
 tskARrmjUOkgg==
Message-ID: <2cbd40e4-40ba-47f2-affe-2bee44bddcc2@kernel.org>
Date: Wed, 18 Nov 2026 10:30:46 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261116040851.2849696-1-daeho43@gmail.com>
 <20261116040851.2849696-21-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261116040851.2849696-21-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTVRm-000000002xd-2tdF
Subject: Re: [f2fs-dev] [PATCH v2 20/20] f2fs: enable subpage block size
 support
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
> All paths now handle filesystem blocks smaller than PAGE_SIZE, so stop
> rejecting a superblock whose log_blocksize is below PAGE_SHIFT.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
