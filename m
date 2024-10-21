Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8143AD17128
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 21 Oct 2024 19:10:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t2xnX-000705-Qf;
	Mon, 21 Oct 2024 19:10:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1t2xnK-0006zE-9C
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Oct 2024 19:10:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ttkl3oNo+YoH8jMkiBTUCC526HjwlvwBQqCsUMkMK4A=; b=SdpFgH9kWu1ORhIhzzjVZZUHE0
 Xrq49DGJPpCcBYIkkRtZ9XQlx31Jh5uwE7LxYZfdy7JrXm+7E5F/4rvLR/XLfPIjL2O/FTItpKyWh
 yEYETre+NtMTRP1Ur/J1bC9bzRgLIcnfq8yrobVYYeaO3l/3Jjq5Rn+jquRpeCjSt/i8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ttkl3oNo+YoH8jMkiBTUCC526HjwlvwBQqCsUMkMK4A=; b=AnW6i1knwg2pfYJ7AwvNk9Q27v
 N9yM1tmKBNTOeY8k9Hft0aGZBBxJBUpJwGL7H3Rxu4mnSqujLZdq8L/eYC8MfLq5fOR7hplHNlbwP
 k7DgsCv/2tM0LI1He1clGC5f916EXGJdKWF+mDpkC7jql+atzyJrVMAbFKtX6XbMFaZQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t2xnJ-00080Q-JM for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Oct 2024 19:10:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B2F6A5C5946;
 Mon, 21 Oct 2024 19:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F563C4CEE5;
 Mon, 21 Oct 2024 19:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729537810;
 bh=LYfZM6Q6uUneW9KRYJEfi2BKTV//PDb/wWBvvJxwfR8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fhS8MIpPoWxTg9VRlPO9/Q30BPSxXPRqalwXfqAi/ZezydoSfQSqJz9IdPNGv08sn
 BX2WZirNj0hQXfKA8AAb64kCR8J3dlJ3/VQN7x/KDyiF3vBRaHAitmtksGjTRx3Gmh
 HxwZnTmVBWmOP4JW4TYRMztJgo8rsRGWD4T4P2cUsb3VsB8pHWQ1loS3BNwaJvgnVn
 OwaXjtFFQjM6gT8tKQqbte4wxL1995C2rWoRXAjx4886cGz6IkulPql2Hz5cgcgD09
 4pAZDg+6PHfU+0VgddrHP5LEVQRt0fnzCrTwrz1DbsA+TzNBMRNb6NL2XSCuzbpxZD
 5CmcqjjNnusfA==
Date: Mon, 21 Oct 2024 19:10:08 +0000
To: Mikulas Patocka <mpatocka@redhat.com>
Message-ID: <20241021191008.GB1395714@google.com>
References: <20241018184339.66601-1-ebiggers@kernel.org>
 <b56689c6-c0cd-c44e-16fb-8a73c460aa87@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b56689c6-c0cd-c44e-16fb-8a73c460aa87@redhat.com>
X-Headers-End: 1t2xnJ-00080Q-JM
Subject: Re: [f2fs-dev] [RFC PATCH 0/4] dm-default-key: target for
 filesystem metadata encryption
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

On Mon, Oct 21, 2024 at 01:52:58PM +0200, Mikulas Patocka wrote:
> On Fri, 18 Oct 2024, Eric Biggers wrote:
> 
> > This series adds "metadata encryption" support to ext4 and f2fs via a
> > new device-mapper target dm-default-key.  dm-default-key encrypts all
> > data on a block device that isn't already encrypted by the filesystem.
> > 
> > Except for the passthrough support, dm-default-key is basically the same
> > as the proposed dm-inlinecrypt which omits that feature
> > (https://lore.kernel.org/dm-devel/20241016232748.134211-1-ebiggers@kernel.org/).
> > 
> > I am sending this out for reference, as dm-default-key (which Android
> > has been using for a while) hasn't previously been sent to the lists in
> > full, and there has been interest in it.  However, my current impression
> > is that this feature will need to be redesigned as a filesystem native
> > feature in order to make it upstream.  If that is indeed the case, then
> > IMO it would make sense to merge dm-inlinecrypt in the mean time instead
> > (or add its functionality to dm-crypt) so that anyone who just wants
> > "dm-crypt + inline encryption hardware" gets a solution for that.
> 
> I we merge dm-inlinecrypt, we can't remove it later because users will 
> depend on it. I think it is not sensible to have two targets 
> (dm-inlinecrypt and dm-default-key) that do almost the same thing.

The code would not need to be duplicated, though.  E.g. dm-default-key
functionality could be added as an enable_passthrough option to dm-inlinecrypt.
Or the same .c file could register both targets sharing most of the same code.

> I've got another idea - what about a new target "dm-metadata-switch" that 
> will take two block devices as arguments and it will pass metadata bios to 
> the first device and data bios to the second device - so that the logic 
> to decide where the bio will go would be decoupled from the encryption. 
> Then, you can put dm-crypt or dm-inlinecrypt underneath 
> "dm-metadata-switch".
> 
> ----------------------
> |     filesystem     |
> ----------------------
>           |
>           V
> ----------------------
> | dm-metadata-switch |
> ----------------------
>       |           |
>       V           |
> ------------      |
> | dm-crypt |      |
> ------------      |
>       |           |
>       V           V
> -------------------------
> | physical block device |
> -------------------------

Would this have any use case other than what dm-default-key does?

Keep in mind that dm-metadata-switch would have to pass through all sector
addresses unchanged.  So if you wanted to reuse this to actually put your
filesystem metadata on one disk and data on another, this wouldn't be very
effective at that, as both data and metadata would take up the full space.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
