Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07009606A878
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Nov 2026 21:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fE6jz91O;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NvAboFwP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WTwR1L8Y;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MAca+erH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EcliD03+CWPd1ZBRhJLr2U5eDYIFInIyxPrgfYc2Iic=; b=fE6jz91OJp9yz8KT6YujlGb0GK
	lnv4stXJF7behsesO8czByyMwSL9sZJJDYiKCiP8Gy6C0Xdh6ahMNxJbG91SVRpB8rnrd6rDFmiGt
	6Gl60U+1TOSLizZ1rYRJAbdy7Zx0QhYpTPcq8zgcGMYz+yjXu0STjIiQDaW1+JXDtCgk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOizq-0000000037K-2Exj;
	Wed, 04 Nov 2026 21:58:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ebiggers@kernel.org>) id 1xOizW-0000000036y-1XnD
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 21:57:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Pt10OpIafDHO+/s8UZzP68e4Ey+bkeQd5gvZCMNXoJs=; b=NvAboFwPu8czRLtYVrCsUj+L4d
 WSshLDspC80/CZEXttLVWIz13cyfV5ZTxJhP6+5D8peLiorbUA9x6oaBW2R3jnGEQsvrBbdetg8ps
 o6L8BRajhxbhB0B1cGnKWoVp65vFCEJlyS3QgwmYaOsxQ1/nnQc2+85SOf7Z6SEWJH4g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Pt10OpIafDHO+/s8UZzP68e4Ey+bkeQd5gvZCMNXoJs=; b=WTwR1L8YVItq6OpdopkgQcLuzz
 8un7TeWJng05s6H1nsIESZcXtftu186tHKJ7apA8CVkvmv+uEK5gQ3VCPcAlKXSCBlnbpdHPHLpDi
 ksI34AtfupeTbovg9/cSq70Q1ZK7KO0r7RPozMKTRiA4AJqiZI+yp8Aq5jfbDsrYXg/s=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOizU-000000007jl-3QuK
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 21:57:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 76CD8433FE;
 Wed,  4 Nov 2026 21:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110E91F00A17;
 Wed,  4 Nov 2026 21:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793829471;
 bh=Pt10OpIafDHO+/s8UZzP68e4Ey+bkeQd5gvZCMNXoJs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MAca+erHy9DR7OyreR+xCs9Mb/ZuNFmIA1Px0E9Wf3rP6Bz4Md7LYWALQDukRMQdh
 P5pYWT9fx/UHsEJMno83Tf61qCmIeZSI3bKLpodUjU2ty4+MzYeswuyT857wesl9r7
 QEWaeuWTjq0lUPDsfeSFMK5ZcCnDTs1q6YqVV8sEIe2bUb7gLV0Ir3bTQlp9CVhUPz
 yc+hpzv6ncSncR+9+aWvAnAJxCwiCAL1amJ6wsw9t5bDBUWDSxU4yRwKgXVTyS/3iN
 +6xPgugAWGGs1A37hLKpGw285h8qkstXE7CkrflkXghHAyhWwqcqh7GFa+kvdLKtw1
 nb4ye4C9X/LqA==
Date: Wed, 4 Nov 2026 21:57:49 +0000
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20261104215749.GA3648616@google.com>
References: <20261104194618.103332-1-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261104194618.103332-1-aalbersh@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xOizU-000000007jl-3QuK
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 08:46:09PM +0100, Andrey Albershteyn wrote:
> Hi folks,
> 
> This patchset lifts two things from filesystems to VFS level:
> - No-oping FS_VERITY_FL in SET ioctl()
> - runtime fsverity construction flag
> 
> The first one fixes BTRFS get-modify-set loop with
> FS_IOC_GETFLAGS/SETFLAGS ioctl()s, as it does return fsverity flag but
> not mask it out.

Changes to 'struct inode' should be Cc'ed to linux-fsdevel as well.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
