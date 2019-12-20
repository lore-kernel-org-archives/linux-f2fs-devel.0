Return-Path: <SRS0=niwW=2K=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F191C43603
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Dec 2019 05:10:55 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1305227BF;
	Fri, 20 Dec 2019 05:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="L6pEnHsN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Z+pYyhnE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWETL7Lz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1305227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iiAYw-0003cZ-JJ; Fri, 20 Dec 2019 05:10:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1iiAYv-0003cK-28
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 20 Dec 2019 05:10:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Hul5tYIgh54eiGCZrIOQgIgQ9IMexTqDiXCm/vGPT4c=; b=L6pEnHsN3YSbgMjmn+H3JcnJq2
 ji1WRWk/6TASOzE07TAW1arptuYmkF1prPvgTmkDnCIZLK7wnZx82Jrgx1F+5nYZBr4ZS8Bf1LtTe
 rlj8WHhA/MGuLHpZFMCU/vQozVTyKNPdyY1VHPdTDZ41vKA8jfiUS/g7/5iBLB6tq24o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Hul5tYIgh54eiGCZrIOQgIgQ9IMexTqDiXCm/vGPT4c=; b=Z+pYyhnENcXcsE7tn6KHogmcJf
 PEOngVgqix+zyY5QobT3ahRCNdhdrwPT3Fa3Y9+8daEo1cl4aDdsVM/3dNvm0x9/MaAvL+3yWlaly
 rNEjANusrzoPB3YZV5hXtoZuTJijWRT2TDHVHa/uitEFr4Fo0S3bQGaIZ4aXFaSWoiPI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iiAYm-00Ai4t-6n
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 20 Dec 2019 05:10:53 +0000
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net
 [24.5.143.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 54001227BF;
 Fri, 20 Dec 2019 05:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576818638;
 bh=EsQwVleOkQSbN4HSmdTMp1F5mGJkLCIuwjwRgIoHL9o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OWETL7LzZvhtFii87WBO8PsOBIKERTQk2mfOdAClWrQxJ15Gw/XjDXjmI7MoBIICX
 Fpc0yKZFf91HSV1c8lRzvUGwEqw6oCI2tLWdpjgCUT+93WoV7lTVq7rl/GrcbnA5q2
 CVg2Nc6rhhy6tUursJJtXKMdeKkw0LsoJ0r13Dvg=
Date: Thu, 19 Dec 2019 21:10:36 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20191220051036.GE718@sol.localdomain>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-4-satyat@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191218145136.172774-4-satyat@google.com>
X-Headers-End: 1iiAYm-00Ai4t-6n
Subject: Re: [f2fs-dev] [PATCH v6 3/9] block: blk-crypto for Inline
 Encryption
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
Cc: linux-scsi@vger.kernel.org, Kim Boojin <boojin.kim@samsung.com>,
 Kuohong Wang <kuohong.wang@mediatek.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Dec 18, 2019 at 06:51:30AM -0800, Satya Tangirala wrote:
> diff --git a/Documentation/block/inline-encryption.rst b/Documentation/block/inline-encryption.rst
> new file mode 100644
> index 000000000000..330106b23c09
> --- /dev/null
> +++ b/Documentation/block/inline-encryption.rst
> @@ -0,0 +1,183 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +Inline Encryption
> +=================
> +
> +Objective
> +=========
> +
> +We want to support inline encryption (IE) in the kernel.
> +To allow for testing, we also want a crypto API fallback when actual
> +IE hardware is absent. We also want IE to work with layered devices
> +like dm and loopback (i.e. we want to be able to use the IE hardware
> +of the underlying devices if present, or else fall back to crypto API
> +en/decryption).
> +
> +
> +Constraints and notes
> +=====================
> +
> +- IE hardware have a limited number of "keyslots" that can be programmed
> +  with an encryption context (key, algorithm, data unit size, etc.) at any time.
> +  One can specify a keyslot in a data request made to the device, and the
> +  device will en/decrypt the data using the encryption context programmed into
> +  that specified keyslot. When possible, we want to make multiple requests with
> +  the same encryption context share the same keyslot.
> +
> +- We need a way for filesystems to specify an encryption context to use for
> +  en/decrypting a struct bio, and a device driver (like UFS) needs to be able
> +  to use that encryption context when it processes the bio.
> +
> +- We need a way for device drivers to expose their capabilities in a unified
> +  way to the upper layers.
> +

Can you add an explicit explanation about how inline encryption is different
from "self-encrypting drives", like ones based on the TCG Opal or ATA Security
standards?  That seems to be a common point of confusion.

Also, this documentation file really ought to start by briefly explaining what
inline encryption is and why it's important.  Then only after that get into the
implementation.  Don't assume the reader has already read a bunch of commit
messages, cover letters, articles, code, etc.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
