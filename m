Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D13BC47DD9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Feb 2024 02:59:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1reRDb-0002NU-ND;
	Mon, 26 Feb 2024 02:59:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1reRDa-0002NN-2D
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Feb 2024 02:59:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Hsi8i5c4p5SDMOkwVLYlGrDFxN5uMd8SgW1qu+/uB3s=; b=DGYuix4VQeSu6TgN5MbMXuEEJm
 6mfypXkrJQf9rEVHPc3hu3TAMybSlvL4NBa44uLpuIitdmKuVmjgNJd2a0dNwTijPTjutS0BsLZVG
 ZdMLuYUVq3gmuN3zcpbqqHgVQbB3Qf467KOyCiT8LBkAZooZixhtkDM6i+ErA83bbTk4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Hsi8i5c4p5SDMOkwVLYlGrDFxN5uMd8SgW1qu+/uB3s=; b=jidUvinKahLnbcLHf04Ag0HJEr
 J7F3JIP5NS9xBigQjluohAc2SOcpvcYVfuRPlgGQTIK229irgjgHdJi8/ueF2bjA1PapaMARRfYjS
 cFuSWZAMh22QxnOnf2Vtm2mn81MCBsIvqT0WHtmBXk0U3ls332YvaEaNa7fAYHwMyPqA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1reRDa-0002cu-2E for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Feb 2024 02:59:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A37C360AFF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Feb 2024 02:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C75AC433F1;
 Mon, 26 Feb 2024 02:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708916379;
 bh=taKs/RPbNJKiITCMU+JxhHq8kEWFW9sKdPpxHB/iRHQ=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=oudjE6McByKnZwSCcQDqCnm/MOwr6ZFScZTuxETM9ZtzUvbFWr0+uPg0VtSQIxJad
 AXwV/LQLDTAfRDFTlNZhfZeQ7cRE5XdTtDSPm4ZBLmviIp4Vv1d+gS769OQIvm24/v
 WRlKBh6AE7NcXN48/uVNrFHgLos55hiFo9e7fPHC7HOf3S1o7ki/dyCeD7wsvMyG5q
 Aslq3s9YP6sOQB8/axCHcUK4cTNtIEHLap3hODqMb/VzeDlpV9Rq90PcNtYDdNTa30
 BKz6LX/tBO4UIIzZLiA5uE0SXoOT26tUt3xLfwUDoJzWPBy8mQGuQZ1ObeZaKVRW7K
 uKnJbxaBfihYQ==
Message-ID: <b0ceea04-19e4-45ad-aee5-8ca3585e2171@kernel.org>
Date: Mon, 26 Feb 2024 10:59:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240223205535.307307-1-jaegeuk@kernel.org>
 <20240223205535.307307-5-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240223205535.307307-5-jaegeuk@kernel.org>
X-Headers-End: 1reRDa-0002cu-2E
Subject: Re: [f2fs-dev] [PATCH 5/5] f2fs: allow to mount if cap is 100
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/2/24 4:55, Jaegeuk Kim wrote:
> Don't block mounting the partition, if cap is 100%.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
