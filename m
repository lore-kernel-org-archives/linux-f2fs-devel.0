Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54B5C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Oct 2022 08:33:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ogMKG-0004Kv-Uk;
	Thu, 06 Oct 2022 08:33:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+f65f4bacc3f57f5be703+6983+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1ogMKE-0004Kp-A4 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Oct 2022 08:33:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ogIdAYV0BU8EWus85GBp3cFwq4ZzocrCrMeVOE5lBWM=; b=JXrG3B8gGzwcB0bedxaimhPH6L
 oDo2QsheoBy+pM4EdWqm58sQCXqtV5wE0pYbbiq/U+uTIF5d/Or/l7z3jHPVhIXA6lbUtqjFpgPVW
 wlfDYJDGrVpYSHXH9/3E6IV4TRnXEMds+ihuc1MVtjYgEELhooCN4I6DSEEWKNGxDzQg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ogIdAYV0BU8EWus85GBp3cFwq4ZzocrCrMeVOE5lBWM=; b=if4H+7R8duPw7RHzn0gEoe5OTN
 foc+DVhQWdwGi1GVys7tVtKgS5ZHpIMmyurpKCGupAShUOzG94F2TkY+VXTBJFTbjF2VBQ1AZ/WcV
 RY+StUubEPEfpmxXI7HtsbLr6v/3X2n774aljptRpugfIbusxVilaO1JN4JVXgwBpDNk=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ogMK9-0002jw-7T for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Oct 2022 08:33:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ogIdAYV0BU8EWus85GBp3cFwq4ZzocrCrMeVOE5lBWM=; b=TUGg3whQm37FJ05L4DSFnjJAns
 RR+fr29Vr9AwrH0dgUR98gNB3JT5YNboOpXzx0ek1KcxGD6LTmXsTFuo0Xlo+6o36R//hJ49vHn0j
 gJKuI+DnJ3x2UpdVYmEb7vn6ypxMIdev+8RHD44C3zHxi7yIo4/qyVIkC9RIoE5yjScIQ8PWOP1xr
 jJ4BAsUxrtNo6AvbCwUQX39G0hMERbYad84Gf7/HH4MYDKO11TONDhpBHwnIitdhgHvY7+fDXxqIt
 wyR05XPCMWM0rjL3UhvJbw8t9RtDgAT2ks69dLeDNPYLLCFQty4U6YYZrsMcW6Lg194NG4FDdqEqB
 ggEMOmJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1ogMJy-000ips-6T; Thu, 06 Oct 2022 08:33:34 +0000
Date: Thu, 6 Oct 2022 01:33:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daeho Jeong <daeho43@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <Yz6S3kP4rjm5/30N@infradead.org>
References: <20221004171351.3678194-1-daeho43@gmail.com>
 <20221004171351.3678194-2-daeho43@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221004171351.3678194-2-daeho43@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1ogMK9-0002jw-7T
Subject: Re: [f2fs-dev] [PATCH v4 2/2] f2fs: introduce
 F2FS_IOC_START_ATOMIC_REPLACE
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
Cc: linux-fsdevel@vger.kernel.org, Daeho Jeong <daehojeong@google.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Oct 04, 2022 at 10:13:51AM -0700, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> introduce a new ioctl to replace the whole content of a file atomically,
> which means it induces truncate and content update at the same time.
> We can start it with F2FS_IOC_START_ATOMIC_REPLACE and complete it with
> F2FS_IOC_COMMIT_ATOMIC_WRITE. Or abort it with
> F2FS_IOC_ABORT_ATOMIC_WRITE.

It would be great to Cc Darrick and linux-fsdevel as there have been
attempts to do this properly at the VFS level instead of a completely
undocumented ioctl.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
