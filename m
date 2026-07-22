Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AA0C44539
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TaRaAhTwN24DxRHLfUCiQ0bnIOOxQ+DMz90bVO1FHPU=; b=aqT+biKdRQm7UN385m3IYGYJP3
	rBEBZTHfZknP1OWLB4j5E7lhZaOA+pgNHYg13RBJ/hEobwmm89boZ/WRx6cL/qriQ7xVR61/Lr7SO
	pLTn2IRHdLe577RAoghYTIx12WeGvC72bZWWuh12q4hiPfaYBahkDk02/3X0qr60tzHo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmW7c-00022u-Bd;
	Wed, 22 Jul 2026 12:32:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wmW7a-00022n-Hq
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 12:32:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m0Y/uZeBndZkCpocqFDwBTaWaybc7JyISltkIQHYis0=; b=G6TAQnJz9Z0p+VxNnVJXlk5ILb
 9Xwzs8AT+0hO6Sv/tHUC3pzprTyxeXQP3bp19IgQ1QjAgjsayw8DFUC49xEEmzx2fBOc/rRnZm763
 2uGBY9lt3wMy3pKSPVuq9uhBG1rYhF3qKlJG0c7VOxAASiZFqn9Dx2pAGp7WyPz8Re7w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=m0Y/uZeBndZkCpocqFDwBTaWaybc7JyISltkIQHYis0=; b=RNx1zvEQOznaOjX/O/YniI94XI
 f6JBqFIoMP+fScaQi2xnXdA/8GUG9ba5iFKmcl6sLxgi4qwCMsK6FZbNdDRYrBO3xprBZIEmWzXgD
 v6TIoSDBCs5nUqCNIACqcBjMkQTcWyPyiG5LHehrTqRXhmxUnrjGGsOrM3Or1x/paeaQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmW7a-0004rD-R5 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 12:32:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 214FE600AF;
 Wed, 22 Jul 2026 12:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A621F000E9;
 Wed, 22 Jul 2026 12:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784723531;
 bh=m0Y/uZeBndZkCpocqFDwBTaWaybc7JyISltkIQHYis0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=VuIE2qi0+vWsykZPrA/2KblJrRVPhJfeAVYpOzPUdbDJJEWClHBH0Me/K874LbUfN
 sLL7DdqRkhMNG0x2Cciz9zyYt28AQ3Ifi7kunPjIpAugBx2DzYnc67bRpIY/xmsxm3
 uO8u/Dp5oVAsLZIMnvC3ZlT0Ow5ImFyojQZzmpyxV+g0lwZOCqMiZ87aCADg4f0Kdx
 yeTfMMCWLpW9qlXgpC0dJ4Y8fgzlFEAlZ4nqxwIzX7ZcN3NrT3TA/M48HnfTqnUFNk
 QAlCM0naof/Z3sueFTb8lMxy27fM5uAGdu+hvzuFBfbG8mwKCxIa6zJwJF7rVNNGpf
 +D4O9UVrS3Dxg==
Message-ID: <ad610328-ed1d-480f-9148-07c9b7a34fe6@kernel.org>
Date: Wed, 22 Jul 2026 20:32:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christoph Hellwig <hch@infradead.org>
References: <20260622070438.1542638-1-jprusakowski@google.com>
 <ajuLORVplOvEXvnI@infradead.org> <akKd2IImO7bRjVV2@zlang-mailbox>
 <e7a57c5e-62de-401d-8e39-f7409f398a84@kernel.org>
 <al3Wcz5pIujPdTrL@infradead.org>
 <1a0bb2ad-c175-4cae-9e3f-79fbf69ce735@kernel.org>
 <amCGfUHu6kI4CPND@infradead.org>
Content-Language: en-US
In-Reply-To: <amCGfUHu6kI4CPND@infradead.org>
X-Headers-End: 1wmW7a-0004rD-R5
Subject: Re: [f2fs-dev] [PATCH] generic/064: allow 50 extents on F2FS after
 fcollapse
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
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/22/26 16:59, Christoph Hellwig wrote:
> Can you clarify what "non-checkpoint data" data means?  Older data?

It is newer data.

1. write data first, and then trigger checkpoint, after checkpoint, data will
become checkpointed one, for such case we can only collapse w/ data copying.
2. write data (data is non-checkpointed if there is no following checkpoint),
then we can collapse w/ metadata update.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
