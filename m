Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAB0606D838
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jKL/HmJ9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IDdmTScU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=czpTcDHr;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7fvykx8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=crsX3M5hZsXgYi1X7dMP9ArSBJKQ4haeckba6uc1vPs=; b=jKL/HmJ9Qx8Xt4fF4Qa+znJIT/
	UR0wYkJgePZTPQttpaR9KXQ6G5kJc/UE8k6uyjer/BWg9tXe1FFFQx4oEsd1rSBC3sLZz6+bp2jcC
	vqQJowgxGE4mPEBqgrGUlY6fRuwCu1IX2JBTi06mNq5Klx8jjaE4lZBToBgEg4cha4I4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOv9Q-000000001tf-0pwQ;
	Thu, 05 Nov 2026 10:57:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <aalbersh@kernel.org>) id 1xOv94-000000001rY-0JjJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 10:56:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kIGFat1YPpHm6A50US9FPElDUzbSDilNLMTmvulOH6Y=; b=IDdmTScUd+yyR1yFIsVLgCNHQw
 DrKW4Tzq/C7hHmDuN3eLJF2Xy0vACa+o5OZtRqwHrjSkxcTdvlq2bpzY+GyPg/w5NEinh3/k2qplg
 sMXZ/dqYF2x5vSi5/5bnFrvCOSTWqa8aTLh1zj6OmOWko838sgzFGsKOCl6twZwLVCxc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kIGFat1YPpHm6A50US9FPElDUzbSDilNLMTmvulOH6Y=; b=czpTcDHrEjQT4lJacotTUE01SJ
 y9Rg3M9DiHe9Io6PsOYJvwew0AgqGaZbTJ2QeeiWUIbjIpL7W2VG5ab3Vj0k2f1EZhHpo8XyaSD0L
 EWdUz8x7kW6/LHmK1ydQ4V4aoTbCkdhh7mk0j71pEwt7fU9WykPggB5vRgR0Q6h63f/I=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOv92-0000000064a-30Pn
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 10:56:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 43A6E41E5A;
 Thu,  5 Nov 2026 10:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D21D1F000C1;
 Thu,  5 Nov 2026 10:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793876191;
 bh=kIGFat1YPpHm6A50US9FPElDUzbSDilNLMTmvulOH6Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=g7fvykx8Ix7cTEWT0bAjqJg/gY8/ovVJxpBlsvj2Tt7NloT1HJAeW5AlaJON46r9F
 cfpMdQh6MQENydfLq+Q8Bkqveli/Sk89/R34mvGQrKJw0dsq2YE/sjpYhpcWwSIf54
 /9jGLdK5yCh1S7lsmW/oLGZqLgYZ9uiWZ7Dl0WGOMAWfcbpfUnB6RwX3sDkfkqHJej
 EumqusUmUrmqAvl6Cl74CSXhTJEUK5c+h+m6n2snl3zEbwlOMnoboEDi5nMkixI2T9
 nb7VvvfxOJPwzDNMTIgSlUQRJYmOtcz3Au2p2msBq0fS6B8Mz/GwVMfZIh5UkJWSss
 +hhWsrEtRUK+w==
Date: Thu, 5 Nov 2026 11:56:26 +0100
To: Christoph Hellwig <hch@lst.de>
Message-ID: <auxSTGvdG-UPqL34@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20261104194618.103332-1-aalbersh@kernel.org>
 <20261104215749.GA3648616@google.com>
 <20261105075244.GB17923@lst.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261105075244.GB17923@lst.de>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xOv92-0000000064a-30Pn
Subject: Re: [f2fs-dev] [PATCH 0/5] fsverity: lift ioctl() input masking and
 runtime inode flag to VFS
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-05 08:52:44, Christoph Hellwig wrote:
> On Wed, Nov 04, 2026 at 09:57:49PM +0000, Eric Biggers wrote:
> > Changes to 'struct inode' should be Cc'ed to linux-fsdevel as well.

ah, thanks! Will resend shortly

> 
> Yes.  Except for that and the two btrfs/f2fs issue reported by Sashiko
> this looks sane.  Please try to do a full fsverity xfstests run for
> all the touched file systems.

-g verity passes for all fs, except btrfs/277 and btrfs+generic/574.

The btrfs/277 seems to fail due to difference between what kernel
and userspace versions support (btrfs-progs v7.1 doesn't seem to
support latest streams v3).

The generic/574 on BTRFS fails only for 1024 block size no matter
the change (fails on v7.3 too). I haven't checked why.

-- 
- Andrey


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
