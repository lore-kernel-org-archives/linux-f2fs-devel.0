Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8523FF8E497
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Apr 2026 02:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=remfTLVjey5jNjzQvHrpmPt5aIm31/8RL9+YOutqSQs=; b=K8PoW7hqLsUGXggWUF/3u8LgAY
	+JJX2TFITHg9A0NwXLiLTzCm901xXzn9+iJzEy5g2oE/jbxB7NxtQNPYWuYNOHK0y7D7bTuawCDPR
	OIlD7H9xd8mS/WNXa+PzSozYaD0YiJxoOARvIj1OkLFbduPa9ligHusiE+kGGC86z+bA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wDZQK-00064e-7A;
	Fri, 17 Apr 2026 02:59:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wDZQJ-00064S-HI
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Apr 2026 02:59:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jthDDulEUlO2VEr46fEjKlRRm3J3QmdTweiTJo0pN+Q=; b=hGF6zEH98jB4wupPx046ki8XeV
 1b0i0MLMQXytR8bABREocHLqh/mEJuC2y8Hqj+6tKU+p+iiBSqDM09WJSWipYXRgXB2xtmqea9lTV
 WfUHwxm2WbcAUXyE1REIAAp6GMPIGiYlSRFYMCMX9os1SCV4O9vMg4ZdWPGnZqMm4scc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jthDDulEUlO2VEr46fEjKlRRm3J3QmdTweiTJo0pN+Q=; b=euG+m/8BGTBjn46c5McSdzRyN9
 LorK/BzcXnS8UiAcRXj3rNuFM+y6/X4mAwYOi/pGmuurLUyUgWdaMHbo5Zls3Nl/2qc5pmPoGMCff
 egRFFVWKHzalcta0cKZvkjYVBOt6zMGSDn6n30SDecoXCvFVIrMMr1Da5SM5AuEnVqLs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wDZQJ-0006HF-Ss for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Apr 2026 02:59:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 393E460139;
 Fri, 17 Apr 2026 02:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EBBC2BCAF;
 Fri, 17 Apr 2026 02:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776394744;
 bh=8coQkp0wolDiPPT+XtdOXRmQ/k5WDstRFadhYQ09xzc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=o5DcyG89py/81kWPC/UdGVhotis9beGbsepDHgkCfibi+rkbVooOrnNMep0xiLIfK
 5s5eRaqJJw0znWaOkz8er6Rhc23CQxkLUdeyn5M9MaEPCn/Hu2YQr8z1oAzc057N8c
 aaPyllxGpQBIvnfeo3OEVnwwu/bgVbfFMXLFPv4qDpgO9R49NTv5lbH8Tu+Jyk9D46
 wPpXspwrdj8ZwzVz9dq0iRDPsTmrG4PF69fhp6x3Fd1TXfJxQNMiPu/NWsrOMH86NG
 jYMXF6Hpi80EGE/lpMpx08CYwbFQCRKL0iWDit4zEyUPP6S0DWjGekBGI2ngtE+T09
 iavABy1HgAf3Q==
Message-ID: <0c24f215-54d4-457c-adbe-e03c815382c2@kernel.org>
Date: Fri, 17 Apr 2026 02:59:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jan Prusakowski <jprusakowski@google.com>, zlang@kernel.org,
 fstests@vger.kernel.org
References: <20260410131821.991005-1-jprusakowski@google.com>
Content-Language: en-US
In-Reply-To: <20260410131821.991005-1-jprusakowski@google.com>
X-Headers-End: 1wDZQJ-0006HF-Ss
Subject: Re: [f2fs-dev] [PATCH] generic/050: handle f2fs as nojournal
 filesystem
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
Cc: anand.jain@oracle.com, wqu@suse.com, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 4/10/26 13:18, Jan Prusakowski via Linux-f2fs-devel wrote:
> F2FS uses a checkpoint mechanism for metadata consistency rather than a
> traditional journal. Roll-forward recovery is only needed if there are
> fsync'd files since the last checkpoint.
> 
> In this test case, files are created without fsync, so there is no
> roll-forward data to replay during mount.
> 
> Therefore, F2FS does not need to write to the device to recover, and
> successfully mounts on the read-only block device. Thus, it should be
> treated as nojournal in this case.
> 
> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
