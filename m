Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBC0D73EB6
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Jan 2026 03:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yJoriBN/YDgcTaO2up0I6YOCaGd9fTB2B1GU3vTTxAo=; b=AYKjh059N9Sv0yFrKS9k8yI26j
	o4eq54tC9Wl+LCDW20ekftvKJeXqyKacYnGLlQdX1XfAPQgPaRn/Ld2EqQSmANT0sm4K9L9P4v9jN
	TKa2OusUERnsPkVpl4Y5RDzOJP0alRvBEaCn696TAoVxzS5kOoiianOZgTxoTmgohAn0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vlewE-0001zD-LF;
	Fri, 30 Jan 2026 03:12:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1vlewC-0001z6-Mh
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Jan 2026 03:12:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pisjMpCl/zmfAoHfoSS4OmtWpOnaiF51cAxLHfo/TS8=; b=Y8p53qnwKtmv9t/G8M9uKBKL9V
 c8lw4pUFySR9We1B999r7BogR+Ecob+8TPu1WfEquIicTOVih+lXEpjULu8DPwyJTkBHvguTey8UZ
 c2DJacr8Dli5lTrL15NKLHmf/9h8+nPKXUWMvABYgzIiGinOM6vJBTLtIHNhUWJl/peY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pisjMpCl/zmfAoHfoSS4OmtWpOnaiF51cAxLHfo/TS8=; b=ikfejosTyJUzK0KRBrnVyJ5YzG
 cdoSJo9dWfEOEztLmWGF+aMFMzceQ24vVIH5FReSMCFoFaHlqTbWCckB9CVKlE7hMvlSP3YSEwFtK
 qJ9fLvgsbWxvis14sBQ838z8G1vffBzJKtQSnPfPZEDU94Qx4Ln9gXYg5mFCILJYNkmA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vlewB-0005Em-MG for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Jan 2026 03:12:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C263060125;
 Fri, 30 Jan 2026 03:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3949CC19421;
 Fri, 30 Jan 2026 03:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769742756;
 bh=ksshzQAuhCriOLBJAnuN0ESDZDnM73Y+Ev6c0KveRPY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=vC5tbbpkkH0jBUE7D5/7VGadb7N2/6u9JnjmfhuSvmQnbhGQdRqXdXYhpRtCv+H7y
 MjXf1YTQIs8WJ3MIfaObLEx0HWy6/V7qvJgJsf5LgT5vvXDzV2aAGAnoADZMtmW+Sf
 lZkXn8UNFvkfr4nMcSznLr+tUkfI9JA4vhJ9ldKi1wzZcCMKI2hZ8zJtoWfNoavpzN
 FE0CymFC3YtI9s8BTLVvmE34N9DfQ3DxB1yOjINnC0KbkjDT/xwct3zB0rDqdwalw0
 dc6WAOx2rcpacLWwd7H6Q1UtOo7GTW6msWT+M6TGRlQ3z2Oc1HOa1yKMG3yG3BYzTI
 vRLn/KBl9fk9A==
Message-ID: <ad6699b5-f04b-4156-b57e-d00c05ea422d@kernel.org>
Date: Fri, 30 Jan 2026 11:12:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260126222801.2229197-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260126222801.2229197-1-daeho43@gmail.com>
X-Headers-End: 1vlewB-0005Em-MG
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix incomplete block usage in compact
 SSA summaries
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
Cc: Chris Mason <clm@meta.com>, Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 1/27/2026 6:28 AM, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In a previous commit, a bug was introduced where compact SSA summaries
> failed to utilize the entire block space in non-4KB block size
> configurations, leading to inefficient space management.
> 
> This patch fixes the calculation logic to ensure that compact SSA
> summaries can fully occupy the block regardless of the block size.
> 
> Reported-by: Chris Mason <clm@meta.com>
> Fixes: e48e16f3e37f ("f2fs: support non-4KB block size without packed_ssa feature")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
