Return-Path: <SRS0=2T6g=FV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756E8C4361B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Dec 2020 16:21:27 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E859623426;
	Thu, 17 Dec 2020 16:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E859623426
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kpw1u-0005kK-6K; Thu, 17 Dec 2020 16:21:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1kpw1s-0005k0-Q3
 for Linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Dec 2020 16:21:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iyrHYTRluogEvhuEgWi7NEPp6OOVRh8Qg1+1ZsPr3W8=; b=a0GYNamqKRTp8XFLFtW19rEVxf
 6yp68gIruRMtVWXhyivYVP2tBIkqdFx0ymY0QbXOc+IRtyfd6nxqerkxP0/99WWKa6rJZS9w6Ho+p
 wHetRdq1jJebp9//GAkZ1Cjiw9KKHiUSDMp6yGygJZWOx9NpzlK/WE2uMAoT5QLy5Kok=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iyrHYTRluogEvhuEgWi7NEPp6OOVRh8Qg1+1ZsPr3W8=; b=gxBtHFol6WbDWS0JTATVdFkK6D
 TiWhpJPjJ3wzsCtCvcqkcBFpwFFeXQBj8G4tYbcw5ady6YbfJBH4fAcRHCIXsPWeXqbSnDwrZo6Lr
 bWwhwcc8seu+NQtbaQu2daaexS2EQ0BUEXWZrU5Le4RiCHO8zBbZkER+2Ct0lrGdwUBQ=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kpw1g-000JIg-ST
 for Linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Dec 2020 16:21:24 +0000
Date: Thu, 17 Dec 2020 08:20:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608222055;
 bh=W5u+pvad/axykBmjsmXhEs741/1ndlQ/YvVXYO26pDM=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=X0VL0643OGLAMcxjcuvUrqExMEeOaZ4u/kngykQZBnbm8PLkG1Y5a6DQkamKYDT7a
 0meokVvdgNHTbUdukClsm8JWQRFLkC9saUzy6tVobn52Low/TbIFHfsSOqf7LFXWUf
 +4rC6NfDCQmWA77yI+HmovWWiYP24QjRGRiraXUdDeOnY1oOntu1qROY+3PzBiQWRF
 c2F6PRJeKQmX2J03YbaNmhJM9JMZCF0InRNf1WC+UmjOnj/7NkvuCGfqOfVa5kLxmk
 d39ZpT+U0pcWOJK+Vxbv3oHSbsk8vBS2pUxjGGXGxA2H0jQR0/WMHX/VedeVk17y8B
 n9KLVKsVcfqRQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: "John A. Leuenhagen" <john+kernel+f2fs-devel@zlima12.com>
Message-ID: <X9uFZThzB+Akb0Fl@google.com>
References: <20201217091457.7807-1-john+kernel+f2fs-devel@zlima12.com>
 <20201217094718.5kbuzdcqcn4nri2u@Lima-1.maple.zlima12.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201217094718.5kbuzdcqcn4nri2u@Lima-1.maple.zlima12.com>
X-Headers-End: 1kpw1g-000JIg-ST
Subject: Re: [f2fs-dev] [PATCH] Miscellaneous cleanup to README.
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
Cc: Linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 12/17, John A. Leuenhagen via Linux-f2fs-devel wrote:
> Sorry, should have prefaced the commit message with "f2fs-tools: ".

Np. Applied, thanks~

> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
