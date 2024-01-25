Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA55C46CD2
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 Jan 2024 02:51:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rSpq4-0005HT-EI;
	Thu, 25 Jan 2024 02:51:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1rSpq3-0005HN-4j
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Jan 2024 02:51:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XepvQzd1na/NY4ybNpIWj2JdpctK98PX4+WlnrGVWdc=; b=NAW6Rh2AfD0yr5oCSYL7XbRq3w
 Olo7pY8qew+3jyjYlLGbBCFuFmNDhh5JsInSu8TdheF+DMM79gCghnh+e09VLgU86nKYKn6wRfIF3
 xvkqxtb/1jf7uupt5+sqCxQwvPVW1smvUGe4GgR0ZDOBeZGwCl8b6H61XFbO+c9breSw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XepvQzd1na/NY4ybNpIWj2JdpctK98PX4+WlnrGVWdc=; b=Gij+N5hy/qyAwqRJJHmQWdOT2r
 dK8ooM7OZeR5J1BuU4PH3Ui1tfsNxm53M7VIM7fObL8nsRpJdvMzrMibeWCiM6hDXmDnUxsLP4j6Z
 Kxax3ybUrWem3RxDkchWTIHzRwFMQGMaDJGSoO7QAE1AtEt93LLwIyoDn7cCdMAsFplc=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rSppy-0004tG-AS for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Jan 2024 02:51:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 32EC2CE32B3;
 Thu, 25 Jan 2024 02:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8D0C433F1;
 Thu, 25 Jan 2024 02:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706151077;
 bh=XAInFk0WFWd1bmvs0vQTX2Dqg3VbW5EExkT+v4E4z9g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Tt+MgVUAAyNuQS03IytFSOwZ5RkSi3MCS9nRWO3cEk6RmdmofFv3pYeoilItLyrvS
 59QQ2SRHM3ZFUNX7mkJEWAlmGVueFeeOd3NzDnHP0Eapsv8JcFpX0AG9mQ4nlpY2xj
 ISIX82+Sp6lyKD4B9fFQoaNKxP096R77hgT8NfCYSVS7ePr7KSr+XqBlB7AOA/9/ux
 dD0KkmV/FysMqLd4FfAFPLe2XwfIxbR/JwWGaDn4XT7lmREQDtJ11Wpp7J6UkfXsQQ
 C3tOiMZU/S/R05IRjqOH70gMQ/lNrJ6Mc+p8HU4xkvva7mS70R6kMQsHR7PesMUyL/
 VrIN105+v9Abw==
Date: Wed, 24 Jan 2024 18:51:15 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Message-ID: <20240125025115.GA52073@sol.localdomain>
References: <20240119184742.31088-1-krisman@suse.de>
 <20240119184742.31088-2-krisman@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240119184742.31088-2-krisman@suse.de>
X-Headers-End: 1rSppy-0004tG-AS
Subject: Re: [f2fs-dev] [PATCH v3 01/10] ovl: Reject mounting
 case-insensitive filesystems
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
Cc: tytso@mit.edu, amir73il@gmail.com, linux-f2fs-devel@lists.sourceforge.net,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jan 19, 2024 at 03:47:33PM -0300, Gabriel Krisman Bertazi wrote:
> ovl: Reject mounting case-insensitive filesystems

Overlayfs doesn't mount filesystems.  I think you might mean something like
reject case-insensitive lowerdirs?

> +	/*
> +	 * Root dentries of case-insensitive filesystems might not have
> +	 * the dentry operations set, but still be incompatible with
> +	 * overlayfs.  Check explicitly to prevent post-mount failures.
> +	 */
> +	if (sb_has_encoding(path->mnt->mnt_sb))
> +		return invalfc(fc, "case-insensitive filesystem on %s not supported", name);

sb_has_encoding() doesn't mean that the filesystem is case-insensitive.  It
means that the filesystem supports individual case-insensitive directories.

With that in mind, is this code still working as intended?

If so, can you update the comment and error message accordingly?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
