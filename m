Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB9FC4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Dec 2022 20:55:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p6Hjs-0004N3-I4;
	Fri, 16 Dec 2022 20:55:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1p6Hjs-0004Mx-17
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Dec 2022 20:55:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pkAeVksOWju9c7lHmw5lroq4CZqCa9tWDTf8i2Dhm9c=; b=eFfY8UCQs2sIdJNYmQtR8XxBWe
 OSL9GzNPg/yp4HRCrv8b7f0xTghk4EcFsi6YrRE16haSRx7/jglNAE5iZVCIoauJETG6SMtUmN1MJ
 QVJuNjIlMa1IPWmbDERcJFjWVLNvoFyl6TvqGS+C52XFKxk5pXqmo94Fiq0dbp2xgjOk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pkAeVksOWju9c7lHmw5lroq4CZqCa9tWDTf8i2Dhm9c=; b=llyN1Hdmk9XTCJeDUnFa5mA56i
 iZ705ZCwRpVkZEJDAkdo6bnvTx7ewb5AlyvsaVJBaMm0IsffN+4e40bsWrbV6ZPR+486k7ClHBzMA
 G5q+8ZwaqqDVUHzC/hXRu2I5w72Lr0r1o24EEqeIIQC0Yaf7Bja+S16thR0zXcZ2NteM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p6Hjr-0006XU-Fw for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Dec 2022 20:55:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4B2006222A;
 Fri, 16 Dec 2022 20:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72201C433F0;
 Fri, 16 Dec 2022 20:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671224120;
 bh=Xwcytn+LoirjjEGfFRYRfniLWhHW1mgnIB+bcrZQfrA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M08Tp1Nd4FaewBLlMg7sBZRj6HV+oopMEURtYwNlMRbz4VjYPGQ/qCd+W7pemHb9x
 0vUAuy1Cm5dVMIp7PhWEbp3itnRVeJ8KeYxDynKo1QWtmJpOOpqen99iyVERF4PyCy
 oJBXgXdmZPg3XQxLDaOp/X/scQDEVUl2ugeJiVkCVxSWEW1BvHV2yI/r6mFjbA+fG/
 plymEurGnXR0A74q+mivvOnbm7dVuUbtTHVGlbx8uzOuB2diLWpC1T6gWiLeor9b2i
 ytVWVHlC5efZgfm3nV1xYO9dH6BFQe8jnpcK75vuWSIFj9v42UjwXXru4GKqdoIA9h
 xkNZ64Qu9aIsQ==
Date: Fri, 16 Dec 2022 12:55:18 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Luca Boccassi <bluca@debian.org>
Message-ID: <Y5zbNtaadNGPGHQb@sol.localdomain>
References: <20221208033548.122704-1-ebiggers@kernel.org>
 <eea9b4dc9314da2de39b4181a4dac59fda8b0754.camel@debian.org>
 <Y5JPRW+9dt28JpZ7@sol.localdomain>
 <00c7b6b0e2533b2bf007311c2ede64cb92a130db.camel@debian.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <00c7b6b0e2533b2bf007311c2ede64cb92a130db.camel@debian.org>
X-Headers-End: 1p6Hjr-0006XU-Fw
Subject: Re: [f2fs-dev] [PATCH] fsverity: mark builtin signatures as
 deprecated
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
Cc: Jes Sorensen <jsorensen@meta.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, Victor Hsieh <victorhsieh@google.com>,
 linux-integrity@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Dec 08, 2022 at 09:37:29PM +0000, Luca Boccassi wrote:
> 
> The second question is easy: because the kernel is the right place for
> our use case to do this verification and enforcement, exactly like dm-
> verity does.

Well, dm-verity's in-kernel signature verification support is a fairly new
feature.  Most users of dm-verity don't use it, and will not be using it.

> Userspace is largely untrusted, or much lower trust anyway.

Yes, which means the kernel is highly trusted.  Which is why parsing complex
binary formats, X.509 and PKCS#7, in C code in the kernel is not a great idea...

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
