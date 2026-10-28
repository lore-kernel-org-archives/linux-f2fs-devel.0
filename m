Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08165606A322
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=R+iSMX+1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DeDda8mJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WSq4kUi0;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OePYN9Rv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ksy3kQPF5wwR+WCkM8eYDSDrRrgaLQwMF0hi7vRTwio=; b=R+iSMX+1FRG+KyixN0/oOlvTss
	VxifANIwxPQ3kU14Ze+DpuXgqNifalb81VsoINaoRTRUdtqf+SISXphFqb0vPt4+3GTlyfCVazlDL
	VU8X/7D+0z3r7OtfkIiSdSj36eH3DFbHRmXQ1jqFaDzW5HUbkw5pw3dPAyN53nVIbb5Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xM83E-000000003gm-3y1I;
	Wed, 28 Oct 2026 18:07:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ebiggers@kernel.org>) id 1xM83E-000000003gd-12sr
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 18:07:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z4L3nEOGF+qxkGkMn6bRtZnF7sFx5d4JUIfh1IpPOZI=; b=DeDda8mJmC73M80L066OOBIXOP
 jj6LSDxYNNAFcAX9c7QZA/8PPWhVS1z5tpukYBg14Tdlul2aWQHyoth6G/SGN9qUFeRSOAApKn1pS
 3Q+DtWgiXVPDVDAV2Ferr+DxpZPnm0V029fguw2gu7kY5Ovp9107+m5KhWOJK4anjjwo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z4L3nEOGF+qxkGkMn6bRtZnF7sFx5d4JUIfh1IpPOZI=; b=WSq4kUi0U/EQDTyfyMc4Le3I0u
 HHOgcbpO/SDAtXCOtZZqM1MIbLnxIsZ/xV+zNaY3rnPUPTPgQ+JIHi0zsXtkv1Bl7HBduWAOZ5k9Q
 DrVc4Lfe/0/rQShq4FPsaLgvdepeseqZlkeoPNHMcIsGgF9hwHBle+oDQ7qEN53v8uFM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xM83D-000000006wg-2mns
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 18:07:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 069C660202
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 18:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85D81F031E0;
 Wed, 28 Oct 2026 18:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793210817;
 bh=z4L3nEOGF+qxkGkMn6bRtZnF7sFx5d4JUIfh1IpPOZI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OePYN9Rvv0YAMMAc1zL6t3lYVnztxSYIpNBqx56kavAWJbVUADgpDMfnuj7Ql2/Zp
 sd4IeBtthoNuyT506ZpiEYyshzMT5RowzeHrx9sM6zl0jSvxoaIYOfGV/PyFqy0hjR
 eU1anzCHz8pIriKfUIlbaErBp/yuPQOaiQE/wvZXiGMDdNV3MjqbXbzGtV6pX3W7Ve
 aw1T8v5sEeJBgSogs2giVIvWJve+/Vtj8vLHBAdHl+GfanNvMFeJZ3KWRXsySilAV7
 8oN8nFomVKlfx4pvxFj5EF0p/ZA7CPgXnl2S8PJBlONmzuWcEe+TjdMlGL5DisTDd1
 J0TQuKqDRhD8Q==
Date: Wed, 28 Oct 2026 11:06:56 -0700
To: fsverity@lists.linux.dev
Message-ID: <20261028180656.GC1876@quark>
References: <20261025203831.120095-1-ebiggers@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261025203831.120095-1-ebiggers@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM83D-000000006wg-2mns
Subject: Re: [f2fs-dev] [PATCH] fsverity: Be more careful with return value
 of ->get_verity_descriptor()
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-ext4@vger.kernel.org, stable@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 25, 2026 at 01:38:31PM -0700, Eric Biggers wrote:
> If fsverity_operations::get_verity_descriptor() returns that the verity
> descriptor has 0 size, then a zero-size buffer is allocated to hold it,
> and it's called again with bufsize=0.
> 
> But bufsize=0 is a special case that says to return the actual size.  If
> in the meantime the filesystem has decided that the size is some
> actually valid size, it will return that size, and then
> validate_fsverity_descriptor() will read from ZERO_SIZE_PTR and crash.
> 
> Of course, for the filesystem to misbehave in that strange way, it
> generally would require direct writes to the block device.
> 
> Regardless, fsverity_get_descriptor() might as well guard against it.
> Make it do so.  Specifically, validate that the first call to
> ->get_verity_descriptor() returns at least the minimum descriptor size,
> and validate that the second call returns the same size as the first.
> 
> Fixes: fd2d1acfcadf ("fs-verity: add the hook for file ->open()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Applied to https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-current

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
