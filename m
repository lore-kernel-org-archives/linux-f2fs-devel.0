Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6601BCD343F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 May 2026 04:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=llciA7/jBJKw2gUoQPUPdEtx9piuiM7z6JNU8ai0Zss=; b=Xn8D8BD0UbcCIwqs9ZqW9u4ihC
	4PHP5NXLDsvNOwomVjkSQP/UzEqYDLsX7Dlwl2mpFPDeKqMe4BpFJ+jZVcxfosZiDZOJ0BKU6+rw0
	scpxOHVCy0TzShRZsHDiwVCSM7tMhJfVGSdJMIZPWRRR3T/eq+iCO7lCy3YyzuMQQL60=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wNk3L-0005tQ-IZ;
	Fri, 15 May 2026 04:21:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wNk3K-0005tK-Mq
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 04:21:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NPomADqyDIcMcwbtbimtUMnHbU2Z+dTOnIM4+rLv56M=; b=FouWqmV3IdyA6Z8yxw3dJN5bzZ
 D8XQdbzqpcOnH3DwmY1lOzK1pgz7ew6Duz3GKNo2o2fVI8BIit7rMLxdBuM1E45PtGsiwx4LEOEwK
 qdVtRHkvV0o8WruMH+7sNVzwDCc14dR2kjkVkpYD1VicpTOMDil/q/1AvQrkZCKCPgaI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NPomADqyDIcMcwbtbimtUMnHbU2Z+dTOnIM4+rLv56M=; b=VzjhmMbfQCDLmpk1YwBEOFhQeE
 wl8QZoK0nDEaEbPMQSGpeZoowjhnwIWnmXq03MitrsEmf1emqbN0OdlcEiSDFVWMAH9VQGNEArg5G
 ZT6VsQTSt9N6Pm8O6jCwddntJy0DX/zEnsRSB1vacBbQxWwRQbZ2vRMGlcV6z6zJ0Vt4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNk3J-00016g-PO for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 04:21:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EDA724423B;
 Fri, 15 May 2026 04:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163E2C2BCB0;
 Fri, 15 May 2026 04:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778818888;
 bh=1hwyYbJ/lx4eY+s7V6mdbavb6iE7LNxuin8WYSh1mqU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QCIV9X9efhsVIKh6BkXawkYENMqm3KVWLguYThz2jdXkzCY124o53dtmY+cQqW5jc
 fg5YO7IcbFm05eRMzMiKcogWAFDegXnWbF9aiplGy1wytWEr4+iKRoecMPGcRI+p2Y
 n6BSsZsbNdv5uNvGX1TK2B2s9+y6rfJHg2PsNHmajTdLt0HAqfhBqsCWM8KivLoTZI
 hvMnGxSpcIaZA0HxYHHSyPmbvlsmN4fQb7cxOijXHIyWDv0ODcQvJ2y0uQDSGS0enT
 9vmdjWyoO1Rn6Wtus7puG4bby35MbqI+O+wD+PCElh4qR7oTEf+a/SVCa2vSDdjEg/
 SB+HIZm90HweA==
Message-ID: <5352628c-8c61-4df3-8460-ca44a4fcbb2e@kernel.org>
Date: Fri, 15 May 2026 04:21:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Joanne Chang <joannechien@google.com>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
References: <20260513032009.2300435-1-joannechien@google.com>
 <20260513032009.2300435-2-joannechien@google.com>
Content-Language: en-US
In-Reply-To: <20260513032009.2300435-2-joannechien@google.com>
X-Headers-End: 1wNk3J-00016g-PO
Subject: Re: [f2fs-dev] [PATCH v1 2/2] f2fs/021: Fix mount syntax for
 disabling jquota
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/13/26 03:20, Joanne Chang wrote:
> F2FS has removed the trailing "=" in the mount options for disabling
> user journaled quotas. Update f2fs/021 to try the new syntax first and
> fall back to the legacy syntax if the initial mount attempt fails.
> 
> Signed-off-by: Joanne Chang <joannechien@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
