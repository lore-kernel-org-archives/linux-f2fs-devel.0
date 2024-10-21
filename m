Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F14D17127
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 21 Oct 2024 19:03:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t2xgJ-00023Y-4A;
	Mon, 21 Oct 2024 19:03:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1t2xgH-00023S-1v
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Oct 2024 19:03:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eGknj5bcjDokOudLavIQ6fUBsId0XWCaZylxK4lSdtE=; b=FKkQQHzQ6Vq2GE7cXoxp0veQ/s
 Hobg8EDeVLGqbjkoQHvEuPjRBqUWchS0Wb0cao4Dv3pjDG42uzevNcUFSJ0+yfbznQ/V5dbt582m/
 y1fhAr6os800OMZb+AwIKIi1sd042JECadQ+WQTkoHXY5xUqengEZYf8msDeOkt9wlyA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eGknj5bcjDokOudLavIQ6fUBsId0XWCaZylxK4lSdtE=; b=GPXIvJNvNOd4/p2JNRv9vB34H6
 99fD6hF6LOqWCxIIkKyxzLVgC+yiDg4qz7AqJ2zLBpokG6xX7TAKvyTjQGlIkuIN/49NsANmJutAd
 o1Poznmv3E2WH7kILfbWWFg4WZOwSGKrNfIDmw49PxNyLvJ2VZAYybBgJ2rimOrq2bEQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t2xgE-0007Jj-Rm for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Oct 2024 19:03:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id F08DF5C04CB;
 Mon, 21 Oct 2024 19:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B23C4CEC3;
 Mon, 21 Oct 2024 19:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729537372;
 bh=vsbnNtYOihL02PJdWlvwTbTMZpcopwhOkYgiKqHnc7g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Cp31ZgBxuboh+ucSekXdmlnI3mHdudXaS7XYFnpwXwWiqGdcRZEOzo8U5ia9IlgdU
 Q00gJVrAOakH0PUA/rFTlLRrwwoeKd2LfApKX8cA378JE5RRkvM3Uj95pHY15VikaY
 r5paDpIv0Fim2yM8OB1fhAKrxJEAQc9AZlrqczh6wssbWPGyPB0YDkQdjJ5KBJPmtm
 pGxANDmkvm2gPCXgM+hvzGe+I4ibtpNEyMcOgSkWiqVX/uupV1cgbdn5K38++K9Arn
 /JOZ+ibZYxQBNUHJlaib87bqllhOEmT5zeMwrM4TQtGLd2jnN6pPKmAsz1wlSgltmJ
 f1aPAjnqalVMQ==
Date: Mon, 21 Oct 2024 19:02:49 +0000
To: Mikulas Patocka <mpatocka@redhat.com>
Message-ID: <20241021190249.GA1395714@google.com>
References: <20241018184339.66601-1-ebiggers@kernel.org>
 <20241018184339.66601-3-ebiggers@kernel.org>
 <2caf648d-73cf-9436-2af4-ad530a966592@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2caf648d-73cf-9436-2af4-ad530a966592@redhat.com>
X-Headers-End: 1t2xgE-0007Jj-Rm
Subject: Re: [f2fs-dev] [RFC PATCH 2/4] block: add the
 bi_skip_dm_default_key flag
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
Cc: dm-devel@lists.linux.dev, Israel Rukshin <israelr@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 Adrian Vovk <adrianvovk@gmail.com>, Md Sadre Alam <quic_mdalam@quicinc.com>,
 linux-ext4@vger.kernel.org, Milan Broz <gmazyland@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Oct 21, 2024 at 01:11:36PM +0200, Mikulas Patocka wrote:
> Hi
> 
> What about using the REQ_META flag (it is set on metadata bios and cleared 
> on data bios), instead of adding a new flag with the same meaning?
> 
> Mikulas

REQ_META is a hint and is not used for all metadata.

And while metadata is the main point, more precisely the goal is to encrypt
every block that isn't already encrypted.  That means that the contents of files
that are unencrypted at the filesystem layer are encrypted by dm-default-key
too.  So technically it's more than just metadata.

To avoid recurring "oops, we forgot to encrypt this" bugs, the right model is
really an opt-out flag, not opt-in.  And especially not opt-in via something
that is currently just a hint and is used as such.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
