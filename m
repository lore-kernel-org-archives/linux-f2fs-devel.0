Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A51606A33F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ctr03BlS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HTqGcdI/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BgjObbVP;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mROE1RDF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7wkS84BFDCEy9VxBgobw6bUGCRymnp+wfJlM3Ko1ybU=; b=ctr03BlSm3zZoRysb6QEPuVNUo
	+5VXnZ0BIKMwweXTKgoRtmRbcZh1yi964aTV2lkJz1atMZ8kbFlY2nCz/nY/tk0pCdO3YxxoooyT/
	SqvHeh0h3qZkPT9xID5nrqRNbZwfEnbgnn4SXPvi+yci8jQm5ZY4MiJnkma2640sh17I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUWxx-000000004px-1v6i;
	Fri, 20 Nov 2026 22:20:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ebiggers@kernel.org>) id 1xUWxw-000000004pr-0isx
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 22:20:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Aq8c5jMV6FAXyr7m5r03HEVCZDhHL41cwgsujaioS6A=; b=HTqGcdI/uzFmxs40v2yNx9wWrr
 SYbH4ndHxA6iaufzsuHpat2Ij3dfpx9gv1GG1pJwn/zUB3/yuWxkzCaspLDaBXunuMHwkb7WnQNX0
 56cQlv73j+EOELnAZFjRaYNYfTLPM8tgIHyUOQv8oALDGjz/GQRBVKFgxqMHILNA7muw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Aq8c5jMV6FAXyr7m5r03HEVCZDhHL41cwgsujaioS6A=; b=BgjObbVPVAsHjRd98Oqbr7+K69
 BhWbcaLrNPI0KNNK+tzxd5pw9yidfyQTLrScR/oAvUXZNhMzgVxkuXEjDaMZ53k2Pz+ngM8hOeh0k
 7oJMMgK0I70Q9nRx28UCMgf0Q3C6KzKh6bg0DopXtYPQ41mDCPVWKUGFdqgkxIanIyQ8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUWxv-000000003Lo-3E8l
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 22:20:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 30D34624F4;
 Fri, 20 Nov 2026 22:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A981F000D0;
 Fri, 20 Nov 2026 22:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795213213;
 bh=Aq8c5jMV6FAXyr7m5r03HEVCZDhHL41cwgsujaioS6A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mROE1RDF4XR/10ikQZwTB7UauvDH8Mr0dtNAipdw8X4FBhIUtl4UuLN1CK6fWMrvA
 S6GnDbxs18Gpd9S+N167jEN6pdhS1mHG16PUjB8K1WV6xmBNbQrsVM3FReCSvZ9j1P
 ghEnvSdOgS5O2d5+USYeir0mVGqjfa8uecN4PpOIrF1TBwSv7Mczx7RFXRcYU0tNWs
 Iw+TgsABMdafm2FfaPqUnqKVmigWAcpU8qcKWlnbpj2KHLKtry+JPYVirQVxnF0R8F
 OldD5aP2DlLdJbIkvBTArvseERJ/s2ZYpD0bpeZ9WhZ2TXWU/1YsQ6/EeqWciLHfhX
 B/zHscYkajU8w==
Date: Fri, 20 Nov 2026 22:20:11 +0000
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20261120222011.GC3048696@google.com>
References: <20261120155032.187246-1-aalbersh@kernel.org>
 <20261120155032.187246-3-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261120155032.187246-3-aalbersh@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUWxv-000000003Lo-3E8l
Subject: Re: [f2fs-dev] [PATCH v3 2/7] fs: strip FS_VERITY_FL from
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
Cc: fsverity <fsverity@lists.linux.dev>, Christian Brauner <brauner@kernel.org>,
 tytso@mit.edu, linux-f2fs <linux-f2fs-devel@lists.sourceforge.net>,
 linux-xfs <linux-xfs@vger.kernel.org>, dsterba@suse.com,
 viro@zeniv.linux.org.uk, fsdevel <linux-fsdevel@vger.kernel.org>,
 jaegeuk@kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>,
 Boris Burkov <boris@bur.io>, Christoph Hellwig <hch@lst.de>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 04:50:24PM +0100, Andrey Albershteyn wrote:
> The common use of FS_IOC_GETFLAGS/SETFLAGS is get-modify-set loop.
> Filesystems could return verity status with GETFLAGS, attempting to then
> pass FS_VERITY_FL to SETFLAGS is not allowed.
> 
> The ext4 and f2fs already treat FS_VERITY_FL in the set path as no-op,
> however, BTRFS returns -EOPNOTSUPP. So, the modification of other flags
> doesn't work on BTRFS for fsverity inodes.
> 
> Fix it for BTRFS and anyone else, the ext4 and f2fs masking becomes
> no-op. The file_get/setattr() path is fine here as this flag is cleared
> right before fileattr_set_prepare(). The future fsverity support in XFS
> would also need it.

The commit message should explicitly state that this changes behavior
not just in the get-modify-set case on btrfs, but also makes
FS_VERITY_FL be silently ignored if it's attempted to be set on a file
that didn't have it before.  I guess that behavior is okay since ext4
and f2fs do that, but we should be intentional about it.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
