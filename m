Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67390EE4987
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Sep 2024 10:11:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1soKJx-0002JI-AV;
	Wed, 11 Sep 2024 10:11:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1soKJw-0002JA-0a
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Sep 2024 10:11:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ko/IR7mS750VEpyEtN/jzbanvPrRNmzrKE0+YtX138Q=; b=B84sMOSaSln2z5z74qxU7WnhaV
 3Ej5JH9r0Ab5EwW1zxoJ8hSaC8UCfIVtJdOZ5LsKKIS9q98XFmGFEEvvonsxmcjFxt2GlxYhs7TcV
 zx04JjzsYMlu1+0r2X0cxzyqiU0upiOVlNRhqlWUsAGURw0OXJ7DtrtZCNrUAzlUsIME=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ko/IR7mS750VEpyEtN/jzbanvPrRNmzrKE0+YtX138Q=; b=QfPUn76BL+wEhGK1CQZvmSEho6
 R2oFKuN513pJJF6ei5w+rtCzXKJwylk9b4sqxFfUJe5CIR+Uu/8oZ1X4Ie4YweeyL9uakoT4Kdod6
 Ww2rz76mepO/Gz0VIsCxsNQTecwRCgaokiy3Z7zt6H/KnBFg8ttxj0oJ2s8R26/Fhc28=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1soKJu-0000Bs-Q6 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Sep 2024 10:11:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 7413FA44BE0;
 Wed, 11 Sep 2024 10:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6C2C4CEC5;
 Wed, 11 Sep 2024 10:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726049484;
 bh=YvMlm2ESwrZTXRL5FZVtN11iIJixl70i7lygrB5p/Dg=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=gdyboa+mByyyt7sm45nRTt9KN6uJUXofon0hlSsK51BFmlVXaF434+pK5e7fr1ZGw
 hjzPbop/Y7S4sdrOWER+u7nCPkzfYs/aLUNbQMPLoYxGuA3yGiGgYshRUqLQ32SHm3
 4f6nc8hJtxD140BPsQbt5aNLUYukYdTflgSnKfmsRkkBruDJq0RwAeKMcWQEfwZW3a
 ZgcbS4mEESxLAoj3Hassmyd66dRgxwk7h893ZUHR/+v07E8gwMfJike2CkfZ/ARXFY
 I/fV+11t4i+t26g8EwKBl26XCoyvHn3AlA5LXxkKi4KMzeE2VgbgB+cGJ1pmR87Z9I
 DGc1GiJIjSRVA==
Message-ID: <975e18d5-3870-4503-a5c9-0740e859148d@kernel.org>
Date: Wed, 11 Sep 2024 18:11:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: liuderong@oppo.com, jaegeuk@kernel.org
References: <1726022421-58677-1-git-send-email-liuderong@oppo.com>
 <1726022421-58677-2-git-send-email-liuderong@oppo.com>
Content-Language: en-US
In-Reply-To: <1726022421-58677-2-git-send-email-liuderong@oppo.com>
X-Headers-End: 1soKJu-0000Bs-Q6
Subject: Re: [f2fs-dev] [PATCH v1 1/2] f2fs: remove unused parameters
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/9/11 10:40, liuderong@oppo.com wrote:
> From: liuderong <liuderong@oppo.com>
> 
> Remove unused parameter segno from f2fs_usable_segs_in_sec.
> 
> Signed-off-by: liuderong <liuderong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
