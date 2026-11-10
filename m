Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C749606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Nov 2026 23:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GGKkY1Bk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XjmGAcDG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KUg8srKf;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kBTW1rxq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8foQlchKkyBciIfOWj1HewWDrjVkFiHNlikUl8zXDoo=; b=GGKkY1BkFXhjzcXW3fWKeXdsow
	Aw1ABcBbdmLBiyW6qe00lgUdz76kgeCDwOdI7UUZLoJ/iDsKeUgOC6GAquOtH2nHCJpmVNTbVaAR4
	tH2fmO4+qyRiaOibHxYuU55Xb2jF+ZxJfw/d0nQqVDFk9ymCqK+bwIjyaJfrWNv6Fb0Q=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xQuss-000000006gV-3r4d;
	Tue, 10 Nov 2026 23:04:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ebiggers@kernel.org>) id 1xQusj-000000006g9-364r
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 23:04:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2pIaRdIwsMurNh146HSaQSteAZp0sNsCvcBlMEMyjn0=; b=XjmGAcDGcBVB8qSBSyYzDFq2ml
 EnM5bMlXkm/k/d8cFht6L56+Xc3A3Za2M/rdklJh0dcu0KWDzUMGBceO8PrSdGwYENq2Qf1w/mEjA
 Hqe3ykOC4mwhxWSUAGeXgcPpgvml89slVwxfXwkoMNCCaBaVWjzcP9X1d1Mnk6vyvQq4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2pIaRdIwsMurNh146HSaQSteAZp0sNsCvcBlMEMyjn0=; b=KUg8srKfzwPdMnFYnze4G8PDZZ
 QQ+J8wRwe5qWG65MF31v4qWbx65mEnJQKiMgqDSECd5DiEgKrlwEHI3VWyz22sBTJoxK4HDBU5TyI
 98rlmQj/OiD4QXCdVuSao2ER46gs5EsOY354Dy6euEB6Tr4rEtq4k1YcVQHnzsCWK64s=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQusi-000000003h1-1XPl
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 23:04:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E955A44D36;
 Tue, 10 Nov 2026 23:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AB91F00A04;
 Tue, 10 Nov 2026 23:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794351834;
 bh=2pIaRdIwsMurNh146HSaQSteAZp0sNsCvcBlMEMyjn0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=kBTW1rxq9WZhdtKSM6ZrjLcJDA8KX7zpquW0WCtTZj93ht9JZWcFZTmPvobJNFp5p
 W7fw8ONKkd7a9uW9Mg/qf4xDHmOd8hlnRbFF4foksH2xX7qk3QGzGbJYkAa75ekFwJ
 OzRNYXI4MvxDD+4HZGPSx2NnRi9PmevHAGdVkVYZRdLMTwDjyRsnAHYGk68OvDDay8
 rDnhbCiAaL/Brr0qiCC6247tRAhK2n7XP0yf/xOtZuuMjJqM4qWjPWN7jzk4Svxfvw
 pqYkF6OUqIPT5t0qg/xeybx0vaHstfPqOrvFTHTSgBMM/vz9TsD1LPwReRhbFj1B84
 7XfdQtupW+l0w==
Date: Tue, 10 Nov 2026 15:03:53 -0800
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20261110230353.GI1907@quark>
References: <20261105115532.613467-1-aalbersh@kernel.org>
 <20261105115532.613467-6-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261105115532.613467-6-aalbersh@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQusi-000000003h1-1XPl
Subject: Re: [f2fs-dev] [PATCH v2 5/5] f2fs: use I_VERITY_BUILDING instead
 of private flags
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

On Thu, Nov 05, 2026 at 12:55:30PM +0100, Andrey Albershteyn wrote:
>  	/*
> -	 * Write all pages (both data and verity metadata).  Note that this must
> -	 * happen before clearing FI_VERITY_IN_PROGRESS; otherwise pages beyond
> -	 * i_size won't be written properly.  For crash consistency, this also
> -	 * must happen before the verity inode flag gets persisted.
> +	 * Write all pages (both data and verity metadata). For crash
> +	 * consistency, this also must happen before the verity inode flag gets
> +	 * persisted.
>  	 */

Same as ext4 patch: the deleted sentence (which wasn't deleted properly,
as it left the "this also must happen" clause dangling) actually still
applies.  Just it should be updated to use the new flag name, or else
refer to ->end_enable_verity() returning instead.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
