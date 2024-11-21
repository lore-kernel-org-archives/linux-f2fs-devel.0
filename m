Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA69D743F9
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:15:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tDvnU-0007oT-9Z;
	Thu, 21 Nov 2024 01:15:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tDvnH-0007nR-Ht
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 Nov 2024 01:15:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CjM5iSfWuH4wu6ZSX3/9OET77wPXRKyDxFuj5hsvUyc=; b=PQE4OcVdsQpC2oD6h6jT0GjdT4
 cSeWaIyd/2zX55kHHoISwTCuQ2rdTp7k4B7sOjN4JgdECx0rjvzHX/606+IPAI3+5HLYmL0mrAOD0
 1Lqj4m6zPmfJ5IR6NcH1f8eB+hksXmERd3niGrr8Y9kg988GgNZbYhPMQ9BuhKsjE+3w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CjM5iSfWuH4wu6ZSX3/9OET77wPXRKyDxFuj5hsvUyc=; b=An/BZbpRHiyjgGTANqcVG5e1Ux
 0+0uVr6NKYcmrCsNcIvSW5z0ca8ylRAYvJRUYDWvO0PYCKA19x/uJ6YKz4D9oA+cnmMFSGJAW6Hy7
 gkCA04yi5babV+albkP0hvfAEaeBakPiruFVVWuPW5rOr9suquTKZ9DEBS0qYVIuBLxM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tDvnG-0005Qa-Ue for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 Nov 2024 01:15:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A9AF75C4B8A;
 Thu, 21 Nov 2024 01:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE197C4CECD;
 Thu, 21 Nov 2024 01:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732151733;
 bh=PSgtjaGOCr/DfqS6AkjrSTdXEqqEScdjYghHEjGWkiY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=C8IT7Fse0pcSY+4Houfs00gbd8dCAMQ7KYG7CocpD0kNEbWVm2ADhIrYuAJ89iEja
 R7lXAHWr7OKfoMu2FpV5XLKrZ5qwN9wk6QeCoyxU5s9rVXg6jcISU0IMIAqwtrFyk+
 6MmLedsuvt5PKSrNvUpjheRPSllhFvUGRdj8GDxgw0MTj5NSiAFW58BlJk6nNoUeuD
 iix1IvTpibYXdsgnF847utnzlmkCw5yzoekkfrO3E74dwVW858TghOOvFO7VooXtcG
 fyyA+jvzy9deEaMBSLU4y0G/0yAgQXt3gM0IfOkRX46Y/LRl3kA5SuTjnlW6uItULm
 BJhjELOxFlWhw==
Message-ID: <1364c01c-ecd7-4946-9646-a3e1b406006c@kernel.org>
Date: Thu, 21 Nov 2024 09:15:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20241112010820.2788822-1-jaegeuk@kernel.org>
Content-Language: en-US
In-Reply-To: <20241112010820.2788822-1-jaegeuk@kernel.org>
X-Headers-End: 1tDvnG-0005Qa-Ue
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: remove unreachable lazytime
 mount option parsing"
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
Cc: stable@vger.kernel.org, Daniel Rosenberg <drosen@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/11/12 9:08, Jaegeuk Kim via Linux-f2fs-devel wrote:
> This reverts commit 54f43a10fa257ad4af02a1d157fefef6ebcfa7dc.
> 
> The above commit broke the lazytime mount, given
> 
> mount("/dev/vdb", "/mnt/test", "f2fs", 0, "lazytime");
> 
> CC: stable@vger.kernel.org # 6.11+
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
