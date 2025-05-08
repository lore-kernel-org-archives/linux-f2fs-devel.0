Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6CEC3ABBE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 May 2025 09:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hJDfeOuxUq1ZYNnKHTsTzjr72DZvoR9+zL5pne1zWrY=; b=arOMMAvFa0lsUvYnEWvoHlOqZ2
	HmjiHTBOj3lOSNi5W44dANOxl7oCZshPLOsLnchximWXrsxbLP+ZQZIYdwJoBACDRfCJdLnC0U8jr
	QPg3unEslLMr8cKrUev+UXw/wdBr+K53IEr40lXJuPwJzS5qMzitsV3v7e1YA6OddF68=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uCxRZ-0005mN-Rs;
	Thu, 08 May 2025 09:21:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uCxRQ-0005ld-2G
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 May 2025 09:21:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FP77DK1jhvrUfdX8HVkiMi0Djr2Scu7WvpQ+htSmzdY=; b=hHstyknqr+G1zxsgbnjGn3ArhJ
 cFynon32fLp9hBAN9jW1t2PCJ1G2dYm1vg6sW9XMh1mYFKBSODda16+PKocP0OPpYyNEsQc+8/pMT
 TZQnbmx/WlzOtWsBy6ntREaFWcB4KKjlJCdWVJZ9KLGVk+aBJI2wHdyaq22nUhc9Hwqw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FP77DK1jhvrUfdX8HVkiMi0Djr2Scu7WvpQ+htSmzdY=; b=KBJhfl3it4aXXamfQwrGTpO30l
 Fz91D3pycANTZ+7+EMChZXEO5PmQ+gXcylvujTXhI08uQDArRXAIEQFIOCsnQY50tO8ixXMNS0Jx6
 LdXLQ8NaPzV9V2JXyzaiDhcxyPgHrMKMMx71mjLGrh3aPhxrvnzMZLJ4MxBZAtR+A3Ck=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uCxRP-0001ZD-BA for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 May 2025 09:21:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 9B9CCA4D130;
 Thu,  8 May 2025 09:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEECBC4CEE7;
 Thu,  8 May 2025 09:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746696068;
 bh=OR62SasjAQdChSGRrGGEq9q3azDTEFgd2S3u3Vq2rLk=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=m1v9dChi4TXb2iKccE7sjSfAL9V/oxPlCsJnxmZYEpGw7V/+xPN3+oRgS1wOWU72A
 OBwvnIvF6zeIbu3xn1xOfAg9Wr9Rs73RiVEbdUjA53Kl6UGbJM3xCAWP5XPHb+Ve/H
 WD/oaFBh5gZ1fb4IjKOVe+LR6ROJjNPHPIR6ddtLxcYozto7YKdBVm85s2wErIFUUT
 jqOCz6IlpEeL4qg9gbL3cINdkb21QC91QUUkCOCVYb1iiZPwGywi6rYksBY5EK4/Bv
 ZNKbeT8cX4VZ4L6Jz6S1NTeB0dGDBmHzNcCTpJH6zT5svSzGxCSc1ld+E0HPLBGpyL
 x3IwB+99q1xIA==
Message-ID: <79648a2c-127d-4dfc-b75a-eace3d874fcb@kernel.org>
Date: Thu, 8 May 2025 17:21:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "yohan.joung" <yohan.joung@sk.com>, jaegeuk@kernel.org,
 daehojeong@google.com
References: <20250508074756.693-1-yohan.joung@sk.com>
Content-Language: en-US
In-Reply-To: <20250508074756.693-1-yohan.joung@sk.com>
X-Headers-End: 1uCxRP-0001ZD-BA
Subject: Re: [f2fs-dev] [PATCH v4 1/2] f2fs: add a method for calculating
 the remaining blocks in the current segment in LFS mode.
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
Cc: pilhyun.kim@sk.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/8/25 15:47, yohan.joung wrote:
> In LFS mode, the previous segment cannot use invalid blocks,
> so the remaining blocks from the next_blkoff of the current segment
> to the end of the section are calculated.
> 
> Signed-off-by: yohan.joung <yohan.joung@sk.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
