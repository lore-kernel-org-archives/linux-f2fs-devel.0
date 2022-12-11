Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E238C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 11 Dec 2022 02:15:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p4Bs1-0004jP-T4;
	Sun, 11 Dec 2022 02:15:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1p4Bry-0004jB-8L
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Dec 2022 02:15:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PkBIriTvI7KjKvZb7bzCv8n/uiAwQmBApXEqURSg09E=; b=NH/tbY7ssiHDZDjAuQ3es0u8SE
 kKi7zvDcCYB1Yr5/K9+t0+gQVxcj+zTqviGUM/c8CL6yqC040wtPMYhPAX0Op3cCvOli0Yodxd9j/
 7rMa0vRroTN7RnHCQPKa4kFWOOFMCj+yol7SQuuUFTtOD5QmRuxqAIbCBxBliC3/nkcA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PkBIriTvI7KjKvZb7bzCv8n/uiAwQmBApXEqURSg09E=; b=kkgMLKLtd4EV/ccwM2L3ktcX6Q
 tA/3Uw34ac04tdiDhd3AXqzdQDHwntiGe/2Y/qibEmf4B6pk2QKSmVmITODETs31SC52S2x3hVHpV
 92VVNo1MTd1Me3wc2BdBJ4zxn/vDO/qBpw6HRqXw6NKF0EemHNV3fISSG39AoLNtusO8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p4Brx-00DR0J-Nq for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Dec 2022 02:15:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1270F60C86;
 Sun, 11 Dec 2022 02:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F25DC433EF;
 Sun, 11 Dec 2022 02:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670724903;
 bh=ysAWWkD442+3tVYIkKxhWHOsZpRBubaUkwLhnkAAAYc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=IIlqhXNusQqvl22+XFC0s3Np6aKYzFBRoGuHE5NwURogeUzQ5veuM4fu1ipRUGNn5
 RLPyEqaWuqO3+aGqyxTLpLkcls43TEkL+Efnet+K0isXC/O/ZoRspy9zatJv5ZV9zs
 fXrzh60O4IlF/NOMyFWhMopJyFSc5fXwt+sh+KRCPKoZmp8ZNz0NiUdkGOMt8eNdtZ
 I0eEyMnGEKqoaeev0lGYyr9cqz7ts2TGUUiXCvWjvoDnqgnWKXY6yFvdVIjQE5TA5n
 hEBp0owxKemEI99ZFjhppwx0Auopxo1lSEMsL76VRP2LAl4qbQh6fMX1rpvlfyKhW6
 2vDy7vvGavaIA==
Message-ID: <05a1dff7-ae67-9804-0556-ded5341d200b@kernel.org>
Date: Sun, 11 Dec 2022 10:15:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20221124033708.10580-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221124033708.10580-1-frank.li@vivo.com>
X-Headers-End: 1p4Brx-00DR0J-Nq
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove F2FS_SET_FEATURE() and
 F2FS_CLEAR_FEATURE() macro
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/11/24 11:37, Yangtao Li wrote:
> F2FS_SET_FEATURE() and F2FS_CLEAR_FEATURE() have never
> been used since they were introduced by this commit
> 76f105a2dbcd("f2fs: add feature facility in superblock").
> 
> So let's remove them. BTW, convert f2fs_sb_has_##name to return bool.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
