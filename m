Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7DE606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 24 Oct 2026 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gM3I6l7t;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IeCzKxNC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=X8l6ALf3;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NYz2U1JU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xLtyEFOH6arYl9oTLnUBZLJHfACHDE2Oo3wRmdRQJm0=; b=gM3I6l7tyE9CsD2y+9lkjqbBVF
	Eq2pdVmtYAMLxpOoIPSaSxekRK5gZC5iNwkgvETYRgMTNyWzEL3v60X0JQow0+Pk3yCigtPDjKYdF
	9w4vxctgs8nFvfh5MaXIn9ooeJ4TqZlIX47CkxPoCq1SuqW2sHdyBdbAizl38WMj5LS0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xKhI2-000000008IJ-1Y0q;
	Sat, 24 Oct 2026 19:20:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ebiggers@kernel.org>) id 1xKhI1-000000008ID-2RdF
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 24 Oct 2026 19:20:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zupueEs92LLYhplKMYURHzUt9KCcFQQdwtlOs89HPOI=; b=IeCzKxNCEKPeDI+WjVOA1UqDid
 bgpi7nSMls+qQqoZILkktn/apmxavY4kABylfPKoYRoc4aU5DKf0Ic3tAsMfsOAdgsPL7e1gvW38y
 V7dv0cJe3668CbyACDDvoidOAHEQZcKE94V0Yonol03pxFvLxKOeMIOW/J1HvZ5dPq6U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zupueEs92LLYhplKMYURHzUt9KCcFQQdwtlOs89HPOI=; b=X8l6ALf3mrMxeKOM4btInQtSGH
 xQ7TpelOPG4AYDCxXs6WziUx209busPJzNLKtNITTMox/utqPRa7NHLD6a0Dvv+JZAkKO3guphKGT
 7wehkOeAMsNd04B5SnGeAFH3hX+XFrAGGWMgz/12CVFczpIjuiG2LYY7GUOxfgCZftiA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xKhI1-0000000017M-0mN1
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 24 Oct 2026 19:20:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D3D1941FFD;
 Sat, 24 Oct 2026 19:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8894B1F01825;
 Sat, 24 Oct 2026 19:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792869619;
 bh=zupueEs92LLYhplKMYURHzUt9KCcFQQdwtlOs89HPOI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NYz2U1JUdsTsXpsZPMHyY+GfubyW4W5DiXoocXwqCA7aiJE8dNB8zaX3eNCMkxldb
 A5Y3ccC8BQj1aJhLQSJCmr+L5eOwFy+6N3fpV3GXuLvbce9Xy1hlbrtjX/WIRQeK/O
 0dvx6ZI6szQz+Nrkwr90sD6Ii7OSkBcflLfRdKyHWV7/3o07xNavk9VlF7KxEYPjqO
 9iCi2oVbbllbKEncXfI2ZzlQbpXE0dp3lP35W0nNoW47HtRmdX+YaGjZfVJyMRXFNl
 pDaWb+l4e03a/0mPb0KZm1U0rW7pU1DKNvvQIzYW0VXwNk+RaDK0OE03LZaqChuX9c
 PGiXyFaAIRTDQ==
Date: Sat, 24 Oct 2026 12:20:17 -0700
To: Christian Brauner <brauner@kernel.org>
Message-ID: <20261024192017.GG2553@quark>
References: <20261023-work-dcache-casefold-v1-0-1b0bd5c73a69@kernel.org>
 <20261023-work-dcache-casefold-v1-1-1b0bd5c73a69@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261023-work-dcache-casefold-v1-1-1b0bd5c73a69@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xKhI1-0000000017M-0mN1
Subject: Re: [f2fs-dev] [PATCH 1/2] dcache: don't leave negative dentries in
 casefolded directories
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
Cc: Jan Kara <jack@suse.cz>, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Gabriel Krisman Bertazi <krisman@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 02:44:22PM +0200, Christian Brauner wrote:
> +static __always_inline bool d_delete_drop(struct dentry *dentry)
> +{
> +	return dentry_negative_policy ||
> +	       IS_CASEFOLDED(d_inode(dentry->d_parent));
> +}

Should this also check IS_ENABLED(CONFIG_UNICODE), so there will be no
overhead when CONFIG_UNICODE=n?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
