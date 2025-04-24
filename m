Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97797C369CB
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:46:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u7lfe-00073c-QP;
	Thu, 24 Apr 2025 01:46:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1u7lfd-00073O-DY
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Apr 2025 01:46:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=la40OlHku6e5nDhD6ceH1oCw484Qe8GI2xLHb8VpBMQ=; b=cn2+RBgDck/fw7rtdX5XvXh9BD
 lScNXeV1naEApDz6DkLtVHDgkP1Z1gAlTQY2wXVAySXJ7JzwO7tJRoa/XemXQ2dsR3lzZM8iTTvgz
 fKrlURP431Cd7kUIXW1qCU+InXH0RPO4l0/q6KrSuOfwjzAONaeZBA6ij6y4kKZ/HoSw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=la40OlHku6e5nDhD6ceH1oCw484Qe8GI2xLHb8VpBMQ=; b=K4FsZmu/sRFBaGGbPv7L36sd6J
 uHnvEBpETdwfwGjoaEJR/2c9UbFJQgxYEUy8IDa3p4v6cJ8LFyXgWNyCWr7YisRNSl6LI4Tslg9VI
 3GvUYDooQGEI670f0RhkJWQNreOZ060TUk/bIIKX8jx3uoIjX8E+uyNaz0j5RM/inTTg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u7lfO-0006g3-I9 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Apr 2025 01:46:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 602CE68454;
 Thu, 24 Apr 2025 01:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43ACEC4CEE2;
 Thu, 24 Apr 2025 01:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745459167;
 bh=DezKAkKWgs4uO62+oRZdJbTIlubhcq41mVkGK65Cqpw=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=bNoImwrwTYFSouzV/mK9xm37729WYEdeVzzDlhRdviM1s+8eX6I5sgP5NAVZg0A+O
 vqRyVhHqUqUAbo5ORP+RChUqZTIv5GCmrjTc6JxsHULUDDT8b9FB8yfOm2Hc8OhDlb
 bwRGqORqi/fq8doGo3Tay4qTm8GohfzZU80D+CBKgeMHd7ni64P9z2a/mQx/JFDgZ8
 qT/ZaF+sH1N3gsIBEvqcG6E42aLSuDSK4vH5L+V1uW8x4XmYBrAES7gZkfJaY1Yrdk
 ljoACQnggXameGeRxF1Hk2WpBIsilZAAPRKeQRcB2a2PEPRGX0AQcjVMguSQ0Jcnwe
 euVmFToNi1R2w==
Message-ID: <0b5be0d5-695c-43a8-b17f-313b85e5bf6e@kernel.org>
Date: Thu, 24 Apr 2025 09:46:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20250423204935.2335000-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20250423204935.2335000-1-daeho43@gmail.com>
X-Headers-End: 1u7lfO-0006g3-I9
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: handle error cases of memory
 donation
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

On 4/24/25 04:49, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In cases of removing memory donation, we need to handle some error cases
> like ENOENT and EACCES (indicating the range already has been donated).
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
