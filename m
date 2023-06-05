Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06998C7EE2A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Jun 2023 06:18:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q63Y2-00047E-Ao;
	Mon, 05 Jun 2023 06:18:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q63Y0-000478-RD
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Jun 2023 06:18:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yBSFERzxmuoE+3xiCR4s9rno4AYZqW7LTaN0zMrM/Yk=; b=mBNd4syf9Gc66dZV9SoSAp8STx
 LA6QRwHOFEuLxy5cT9yjnOMveYZtv6h914wLPp79Wu/q8w4kc0QTNFwGxw+F83YorU8FrXUGaM2uk
 VzeSVmU48Xi5FZwd9RTQmtZKfTBU7LtrDeTB/xVM9rvmS2ES9SXiWRcE/0K5Z90D6Q5M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yBSFERzxmuoE+3xiCR4s9rno4AYZqW7LTaN0zMrM/Yk=; b=H8lxm30vhYyp1PyhrBj3ngC0Lc
 poCuEH/uZPNc6Ev+uoIT5H0M1jwGndjot+I4cQUVG1onewiIcL24V18AyaiTfiyFYPNvBB1s1rFzt
 /BrpubjM/cgVwpCWayBCEMghQrjriki+5dDq86wc/riYjsY3DzCoOJlWh9j3Ovt+X3YQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q63Xy-0006KB-5H for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Jun 2023 06:18:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B9C9B60ADE;
 Mon,  5 Jun 2023 06:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7663DC433D2;
 Mon,  5 Jun 2023 06:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685945904;
 bh=XthjLSKpEYIC/tPT7MXvwrgh9hvssfA9IB9vZoB1zCM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rDNtPjQO3M1o/2ix2Mj9vZms30AJjxzMA44IrtkbOHlVEAVganDcWTgNk2QVcww/W
 SLQhjrfjwsiDDc1pcKe0fD6r7yVo6Qimv3136+Zt3IPZqDw3vqcD4/kmIhhtpTq6LI
 9MDwNYw+R2BSTVwpzGjmdss0RraEka1X64QD+m7MIk116AhHZxH7YLwAB+7mDlGw30
 71pRmOz/d4FRqHnKMgi5Wy8bNkkBnoc/IJySdxI9ncRt8kAve2drDF+c6n6+PSVEl5
 pfu1pVbt4fTTRRe8OQDgbERXz+wBooktVtDpmkxt3zCf5EF0rXT8XHuicYwELZMSgr
 ZNMePzE9Kxpqw==
Message-ID: <dfaa57a4-494b-76ba-b181-bf0add5e1c3b@kernel.org>
Date: Mon, 5 Jun 2023 14:18:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Maxim Korotkov <korotkov.maxim.s@gmail.com>
References: <20230605060853.679169-1-korotkov.maxim.s@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230605060853.679169-1-korotkov.maxim.s@gmail.com>
X-Headers-End: 1q63Xy-0006KB-5H
Subject: Re: [f2fs-dev] [PATCH v3] fsck.f2fs: fix memleak in f2fs_create()
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/6/5 14:08, Maxim Korotkov wrote:
> In error handling cases, exiting a function without releasing memory
> 
> Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
