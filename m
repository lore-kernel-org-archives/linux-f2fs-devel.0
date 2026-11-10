Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50357606A326
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Nov 2026 22:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=g81C8sJT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BLpfjXoA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fxXcYeWv;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TOp9f9x7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oreusi1nzC/Hb9TY9UEx04i8khdQzbVxvNFY/rHvo8w=; b=g81C8sJT5NrX4W0zsVYnC3L619
	jNSM9DBrrRW0rTERxeKEoCSA6zVKyDDZhKbNHOX+VzKIEZEpqx9/hp9yi9IanXoXRY5hHFoYdHpGF
	j08HWVxJVFoJbM1cdNlCzBnrL+bjPDMuMXAE0pGAQYPIv1iSDytDoDZLDQ5Cp1hfcFIk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xQuTQ-000000004jC-04fi;
	Tue, 10 Nov 2026 22:37:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ebiggers@kernel.org>) id 1xQuTN-000000004it-47qN
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 22:37:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n8XbVRklTf23qieQRD1VyauRsHNye3gZo1o86GLGMcE=; b=BLpfjXoArCRUkjvVRi9nrtid53
 9BNsMycgMWAE6WYQ2sOd2a79/toIAt5TdctymKJFvV6RtH4cjMsMsCFI8aWKDzbs248F95s6Y7cXT
 62INXatIVt9O04OGPf6dk7mlnk9nfbYi7yvhR+NEaKR6u4ZQ85yK5br2EKqOnZdp2bgc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n8XbVRklTf23qieQRD1VyauRsHNye3gZo1o86GLGMcE=; b=fxXcYeWvI+ni5DcS98bWxhdGvR
 2KlNtfR2yNB6WYBCEYYBtTwle3XiXYiOP6DxHDBDl4MsHQ3x1l5NmcpIywGSyRURTE0kZ5I8L0F2R
 gtG7rxe2Q2h9bT2E77I00hmbL9jJHUKZqiFVZx8oNRpi7DTRZy/Gu/5Lsn6+qC98tChk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQuTN-000000003sE-2CjZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 22:37:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E7302618A3;
 Tue, 10 Nov 2026 22:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECE31F008A2;
 Tue, 10 Nov 2026 22:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794350263;
 bh=n8XbVRklTf23qieQRD1VyauRsHNye3gZo1o86GLGMcE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=TOp9f9x7TncAgXrdmTrTBClcnbzWo8BWTKAM5lNyJpIRpGbGEhz46LODD43Q+nLZc
 f1xpTTvd20e+0sCXnhNoRGahw54LNb/ZkMI50VsPtUyBfiQhGj7dhxIFw2w1LskOMr
 +i95YSLoHjEsKnX9gcyTmc0YVaq8S5qgkeyeic1dVN9dQ85JgYpbkIB3dYGlLhTboh
 YccPuY1BUZpWnT6U90opJJObCAsUf7nNPLbQS8PvKP9+kWyN5/UNOLtGZjnuhfhcJU
 sZ2DX/U7bFjKJaJCwIg17LTdTmBAX6tKkTyb++GMCGZICdU+DDLDvQnDvPIr0QZJBX
 YzPlKGxyB9Z8Q==
Date: Tue, 10 Nov 2026 14:37:41 -0800
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20261110223741.GE1907@quark>
References: <20261105115532.613467-1-aalbersh@kernel.org>
 <20261105115532.613467-3-aalbersh@kernel.org>
 <20261110223526.GD1907@quark>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261110223526.GD1907@quark>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQuTN-000000003sE-2CjZ
Subject: Re: [f2fs-dev] [PATCH v2 2/5] fsverity: add I_VERITY_BUILDING inode
 state flag
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
 jaegeuk@kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 02:35:26PM -0800, Eric Biggers wrote:
> On Thu, Nov 05, 2026 at 12:55:27PM +0100, Andrey Albershteyn wrote:
> > +	} else if (inode_state_read_once(inode) & I_VERITY_BUILDING) {
> 
> fsverity_is_building()?
> 
> > +static inline bool fsverity_is_building(const struct inode *inode)
> > +{
> > +	return inode_state_read_once((struct inode *)inode) & I_VERITY_BUILDING;
> > +}
> 
> It would make more sense for inode_state_read_once() itself to take
> 'const struct inode *'.  Then the cast wouldn't be needed.

Also, we should include an IS_ENABLED(CONFIG_FS_VERITY) check here, so
that it gets compiled away to nothing if CONFIG_FS_VERITY is disabled.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
