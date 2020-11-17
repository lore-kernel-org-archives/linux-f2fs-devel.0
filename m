Return-Path: <SRS0=ovVE=EX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905B9C5519F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2020 18:36:25 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E94C6221FD;
	Tue, 17 Nov 2020 18:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="a8XZcpkN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="CX9OpM2D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDkYXN8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94C6221FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kf5q4-0006cP-61; Tue, 17 Nov 2020 18:36:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1kf5q2-0006c7-RB
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Nov 2020 18:36:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lcUYLjyljO8kM5sjjDFbr1tEkwnODfp0P8Tzh4a21/8=; b=a8XZcpkNiOZ5dYRZSjd/Jcrikl
 J9oRJaO4tTQQ1vUFS62Mev/AnZlppCDSuU4aQtjv1MqgBGx+ESES1jPKXLissnoTt+n42vyKowLjq
 7KzBzHvV8oA3lMq+C3qbsCS7Gm8W3NCUl1k/l5e7kTKn5gqSKcs2UHFdlJ1x7xySAFyk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lcUYLjyljO8kM5sjjDFbr1tEkwnODfp0P8Tzh4a21/8=; b=CX9OpM2DwM8wu7y7nxZ5TaXJzT
 y9oIS1xG/e01rvIc92DfQ+4Xz67jRFLiP7ol0A31S+sNMTUvAkfF2zVv0GxLMH9ilD1XM1VHy8k1n
 XyuQgYDtP0FBM3ysA59rJ4hAwiec9y7SBxsd6fkstvspRUM03JKlhBHmJi9d045NJHWg=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kf5pt-001KqG-NN
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Nov 2020 18:36:22 +0000
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net
 [172.10.235.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AA74F223C7;
 Tue, 17 Nov 2020 18:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605638168;
 bh=XFTKnyksOQF5hI0TvFTXOnV3KR3hpWlZi6TBqSIlN+o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TDkYXN8CuXva+9OJ9b39gOkV0069pK+fKDahpqGUjsGcqRpFilPNA9fKO0pC028pt
 IoJRLdqRMCA9DRRLjwr7kUg0oPUfUKs6w/Tw2vuqqcgbZTDTUEyH/IIqd8BM2F1iwh
 QjPFKNx/xoX0SEq3VPRzU472078pyjJ1hcwl1m/U=
Date: Tue, 17 Nov 2020 10:36:06 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Daniel Rosenberg <drosen@google.com>
Message-ID: <X7QYFm3QIYBhdI7V@sol.localdomain>
References: <20201117040315.28548-1-drosen@google.com>
 <20201117040315.28548-2-drosen@google.com>
 <X7QTkSyiMojM6T10@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <X7QTkSyiMojM6T10@sol.localdomain>
X-Headers-End: 1kf5pt-001KqG-NN
Subject: Re: [f2fs-dev] [PATCH v2 1/3] libfs: Add generic function for
 setting dentry_ops
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
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, Richard Weinberger <richard@nod.at>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Gabriel Krisman Bertazi <krisman@collabora.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-ext4@vger.kernel.org,
 kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Nov 17, 2020 at 10:16:49AM -0800, Eric Biggers wrote:
> 
> Here's a suggestion which I think explains it a lot better.  It's still possible
> I'm misunderstanding something, though, so please check it carefully:
> 
> /**
>  * generic_set_encrypted_ci_d_ops - helper for setting d_ops for given dentry
>  * @dentry:	dentry to set ops on
>  *
>  * Casefolded directories need d_hash and d_compare set, so that the dentries
>  * contained in them are handled case-insensitively.  Note that these operations
>  * are needed on the parent directory rather than on the dentries in it, and the
>  * casefolding flag can be enabled on an empty directory later but the
>  * dentry_operations can't be changed later.  As a result, if the filesystem has
>  * casefolding support enabled at all, we have to give all dentries the
>  * casefolding operations even if their inode doesn't have the casefolding flag
>  * currently (and thus the casefolding ops would be no-ops for now).
>  *
>  * Encryption works differently in that the only dentry operation it needs is
>  * d_revalidate, which it only needs on dentries that have the no-key name flag.
>  * The no-key flag can't be set "later", so we don't have to worry about that.
>  *
>  * Finally, to maximize compatibility with overlayfs (which isn't compatible
>  * with certain dentry operations) and to avoid taking an unnecessary
>  * performance hit, we use custom dentry_operations for each possible
>  * combination rather always installing all operations.
>  */

Last line in my suggestion has a typo: "rather" => "rather than".

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
