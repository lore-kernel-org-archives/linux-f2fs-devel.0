Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473E1CD6E7C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  5 Jun 2026 22:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S6braq2Xoflw4pguGWAeuQ3HPctSCn6zM7Kp7w//doQ=; b=RdxYX0PCVdqLJoT5on551WY2w3
	Rr2zE0sy1mOESx29SaMGfswW/k1YUI/jQT8uBN2HcQuk1MoT4yg/QGfhtybFhNSoRErnQptwqho9+
	gnz3NLPT5BOdxcjaJg3FhdiVlxW1pJeqTIaKZkpJBMs38pYWXHMo/dG+Pi4m++p18+cE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wVckU-0006Ar-Fz;
	Fri, 05 Jun 2026 22:10:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wVckT-0006Af-1u
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 05 Jun 2026 22:10:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iJT3Q7smY0LrmHruOEmo/PCSRB3GG8ERa4x6kmx4d+Y=; b=mmAWXI1VjGaNNPl6mHIgEhzXCh
 oFSULnEmkvoQzKn3yn7veNuSAYGP0LJWqdu0jCZhhwliNINQ5EBjqAXcnQ0KZQnC9VW0s4iCw6wjW
 4UsjDDSZs5Z7GY5Jdt3LhM5fd8XFbP6+C24WeAWDGliCXRz4Ehru2wUo/R0bdci0ArMs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iJT3Q7smY0LrmHruOEmo/PCSRB3GG8ERa4x6kmx4d+Y=; b=Z0n0EFaSIjgybD9A9LoT1/bFHX
 gG7VMgsetN6PB2VH2+MzPN0tx6SjuEUKHLIrEccmU4UOZE4wbdG9/SiswFtS+UOAPeZRDnZnWx7y0
 K4bsZKJVEdoSQgnMA3YjDby7lKo+quGeJeIOd61W2aAy9LKlJSLBp0PlU4+qol4m/lJ4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wVckS-00043C-3C for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 05 Jun 2026 22:10:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DC4DC600AE;
 Fri,  5 Jun 2026 22:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622D31F00893;
 Fri,  5 Jun 2026 22:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780697429;
 bh=iJT3Q7smY0LrmHruOEmo/PCSRB3GG8ERa4x6kmx4d+Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=DZJs1NeGHa6Aj5cGd2/4LKJNYX2ZOA007sU5tt1nQypR4gNWPS3L9LOEZfYrAYKIQ
 RTq217bR6iiqBK2d7qIhYjnUT+KbWjx1CwcLmkqDXnchtgIfICxGsfaVqI1g/rHhjQ
 3bQaKxcYxDY0FdR+r064rlpKMDClNrsBXkPzXQ8V8VlyvWXERTIOMaZjkeGUCd03CW
 /bvma0EHSo8m52mqnvJKuRkL8B8XbrisWxR1u/8GmeJ161Cy/OKrjM752FGbhY4Q4M
 AbLNTaNZSh4pqPSFWH6MO0rpf7I2xEyKdY0tVY66HSW6Gh5RlGEr1ik4a7CvL99VKN
 a9v2JnKDIS3gA==
Date: Fri, 5 Jun 2026 22:10:27 +0000
To: Daeho Jeong <daeho43@gmail.com>
Message-ID: <20260605221027.GA2312230@google.com>
References: <20260605212504.1080138-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260605212504.1080138-1-daeho43@gmail.com>
X-Headers-End: 1wVckS-00043C-3C
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: support dynamic include/exclude for
 device aliasing
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jun 05, 2026 at 02:25:04PM -0700, Daeho Jeong wrote:
> - F2FS_IOC_EXCLUDE_DEV_ALIAS: This reclaims the space occupied by a
>   device aliasing file. It first performs a capacity check, resets GC
>   victim information for the target range, marks the segments as in-use
>   to prevent new allocations, and then triggers GC to migrate existing
>   valid data out of the range. Finally, it reserves these blocks in the
>   SIT to effectively exclude the device from the usable capacity.

Does this do anything to zeroize the device so that random data isn't
leaked in it, or is that the responsibility of the userspace code that
reallocates the device to something?

> @@ -2214,7 +2231,8 @@ static const struct {
>  		FS_INLINE_DATA_FL |	\
>  		FS_NOCOW_FL |		\
>  		FS_VERITY_FL |		\
> -		FS_CASEFOLD_FL)
> +		FS_CASEFOLD_FL |	\
> +		F2FS_DEVICE_ALIAS_FL)

This is extending FS_IOC_GETFLAGS, which you probably don't really want
to be doing, right?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
