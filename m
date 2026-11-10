Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D00D606A325
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Nov 2026 22:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SQ7L7o8f;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DvpNO4r7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cVLIUhis;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DNij6F7O
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LKJFuceVkRrYdSdq+gf6ZTTafxemHZg55AdzstkDqvg=; b=SQ7L7o8f3Y7AZDq4a8DwcdBkRf
	M6xV1kRgCDuO2NXZJVLz2k+9ZPFal+6C7ybIXGZjDv9e7gUmvErHnKZBioYZUykiGQen4VyfZ+kjX
	L1kgrmsQvKqQWNeMQ3VeSmWsfTUQsOq2BVjYVK4ArkU90+wiU61RUDxF3/zev9dLWIF8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xQuOb-000000007hi-1lDF;
	Tue, 10 Nov 2026 22:32:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ebiggers@kernel.org>) id 1xQuOa-000000007hc-06A1
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 22:32:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HQ7x/TllQKscfko1enh7ZEudM21vFfhSSI8zpxm9WxU=; b=DvpNO4r7UvvNeNLhM6EmOZkLe+
 fGvY2+OKD37yOm+XcUfrDGq9lVooSEIj40nBfebra8t0Sx6qL9dqmVE/tMiEomAxscn19vB9wi5YX
 xSqbs+ioz8vzz71oIrPxl28uirXehdNPujZW+v/OBmqS5VvmA1QeQmMqFRTafEHdgUMo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HQ7x/TllQKscfko1enh7ZEudM21vFfhSSI8zpxm9WxU=; b=cVLIUhisVaUyVkOuC2xyYN68D4
 YtiIu3+/9M1q6sNToFjteSHHKkxOXVqrg6tHbvG61c4yZZj8TKUHifrpnan8VyZDRU1EQDHMTYjOZ
 AGGXFJfvfz7gX1MOwWnlWpvhXpJ71d68X8F/5AD9iJ9iwsaVRhSDcV7ZryK99lTtTcxA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQuOZ-000000003lN-2dJo
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 22:32:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A67261255;
 Tue, 10 Nov 2026 22:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A5B1F008A2;
 Tue, 10 Nov 2026 22:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794349965;
 bh=HQ7x/TllQKscfko1enh7ZEudM21vFfhSSI8zpxm9WxU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=DNij6F7OuI5XOtcmTJS7mQ74EjScBg5KrzI5SF+tcsu2XCZXUAdVGJd+QGxFFhk43
 pte2jeJ3BU/3vPPeTE+1dmBTTbYGgf8fpCwOETFKxsyWxbYU78iE98lrc3OtVcnuVk
 bsBTIJbuvu9iTKP2FRHZYizKxaylLy+JMRBIUX+QsL4+WxMt25yiBz/XSVXsMgpxBt
 3A+hlDqapoXwRa2TwXu+dl6mEzo6U0+yKmfX6mLWvLnK0/JJr9FPB11EaxUxVaraEU
 xQE86hHfcG1vNEg3MPDiblk4WTR6NeLEv4RWMypBMM+24R1EeuOgIHwmpTFT+GIJDF
 Fh6I5KRsXxuXw==
Date: Tue, 10 Nov 2026 14:32:44 -0800
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20261110223244.GC1907@quark>
References: <20261105115532.613467-1-aalbersh@kernel.org>
 <20261105115532.613467-2-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261105115532.613467-2-aalbersh@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQuOZ-000000003lN-2dJo
Subject: Re: [f2fs-dev] [PATCH v2 1/5] fsverity: strip FS_VERITY_FL from
 FS_IOC_SETFLAGS
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
Cc: fsverity@lists.linux.dev, brauner@kernel.org, tytso@mit.edu,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com,
 jaegeuk@kernel.org, linux-ext4@vger.kernel.org, Boris Burkov <boris@bur.io>,
 hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 12:55:26PM +0100, Andrey Albershteyn wrote:
> [PATCH v2 1/5] fsverity: strip FS_VERITY_FL from FS_IOC_SETFLAGS

Should use the "fs:" prefix for this one, since it only changes
fs/file_attr.c.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
