Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED34CCA47C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jun 2022 00:58:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o3SDf-0004eq-7X; Tue, 21 Jun 2022 00:58:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <hsiangkao@linux.alibaba.com>) id 1o3SDd-0004ek-OT
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Jun 2022 00:58:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GmWl9nb0ZzYK+qmo9Ld+y46uKE9m83tl1rQ/V6H87WQ=; b=kmbrJwpDQkZyQasDPzpUhaC/5X
 QHsJgmz+dZr7x74EEbpZNgBRedaMe+Ev1fXRVK9HcK6pucObve64SbES0kYsQp5D/fja0uOi+N0Yi
 OpxOWlFQYkQIN5kp3TAlfpkSdNpXrQqxbZEOlxeLQz/+T5cVpW14WCF2pc878kCgAFPQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GmWl9nb0ZzYK+qmo9Ld+y46uKE9m83tl1rQ/V6H87WQ=; b=avTARXk51ak+ONWIli5OQWc8n5
 9/00OgdEJlyN2S6XE/RTt2pJxJorqC7/8yhHapzZAIDH54Lac9c4S1JwmmWs11x9Bc/c+E5dEW8oa
 8ci/Z2SFozUj79SpXRTC5NNXzIAO5e8QFJPjNsqtyvDdED2ae7oVEz+lL3Ei/SnbBQQY=;
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o3SDb-0002Dc-Cl
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Jun 2022 00:58:13 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R591e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=hsiangkao@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0VH-cNEa_1655773082; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0VH-cNEa_1655773082) by smtp.aliyun-inc.com;
 Tue, 21 Jun 2022 08:58:03 +0800
Date: Tue, 21 Jun 2022 08:58:02 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Daeho Jeong <daeho43@gmail.com>
Message-ID: <YrEXmiRH+DcbW2EI@B-P7TQMD6M-0146.local>
References: <20220620173843.1462198-1-daeho43@gmail.com>
 <20220620173843.1462198-2-daeho43@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220620173843.1462198-2-daeho43@gmail.com>
X-Headers-End: 1o3SDb-0002Dc-Cl
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: handle decompress only post
 processing in softirq
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jun 20, 2022 at 10:38:43AM -0700, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Now decompression is being handled in workqueue and it makes read I/O
> latency non-deterministic, because of the non-deterministic scheduling
> nature of workqueues. So, I made it handled in softirq context only if
> possible, not in low memory devices, since this modification will
> maintain decompresion related memory a little longer.
> 

Again, I don't think this method scalable.  Since you already handle
all decompression algorithms in this way.  Laterly, I wonder if you'd
like to handle all:
 - decompression algorithms;
 - verity algorithms;
 - decrypt algorithms;

in this way, regardless of slow decompression algorithms, that would be a
long latency and CPU overhead of softirq context.  This is my last words
on this, I will not talk anymore.

Thanks,
Gao Xiang


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
