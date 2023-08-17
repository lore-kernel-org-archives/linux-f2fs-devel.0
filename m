Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0D7C3DA62
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Aug 2023 17:07:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qWgSm-0002Mt-0X;
	Thu, 17 Aug 2023 17:07:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1qWgSg-0002Mn-UY
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Aug 2023 17:07:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7mrrnkckGW04ZhWPp9T8PtJND2gXdmBdb0j26DVg7hg=; b=V1mgqRpStDNl7hpMODtQEIBAVR
 BgtlXGG0WstIy52V11xlzVGkm50y6iu4LMFrv8QxENg9pQ8vK3LDsjHTU4b5pLbHYGqcoxo+Usz6u
 LUUD1DqxCg+jLpX+z29vi3no/8UUq9K/nxYg3UR/bk5NL8VNanRE44hw1eZSj2VSdkqk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7mrrnkckGW04ZhWPp9T8PtJND2gXdmBdb0j26DVg7hg=; b=TrUzf/WA8fL/cEjcg30FgJ6TJy
 a+IQoRPXoTs9Hoe2QXdHzj/YfBCyU5+Y4efpFfKhEm5jHmuaajjuYdX6ZpTLtmeXkNJA68t9/IXbC
 894MwrzkluYpGtAkJp71iyXd01wQMX+pqhZxXcxL3VIA2vS2Txjg1WjPmY8KDaJgms2U=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qWgSh-0085MU-C1 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Aug 2023 17:07:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A9F7561BB5;
 Thu, 17 Aug 2023 17:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C38C433C7;
 Thu, 17 Aug 2023 17:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692292021;
 bh=Cnc5fd/SEme+J61EWpUydnlttURNe7D0+P6ahO3xQc8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NyA3MyXj29mNfXON4kkdiiJ8iEEdVRKuJxpFf/okQAHl1Ixm51esprU4w/4xqxdYB
 G53DTRxWeVOISwNDLGmzSmrQZkZvuqnwrzknMCqq/9Wv+v4VQzvDEKw5QXOazQ4JuP
 8SlXP4+QjLaDNKZ0oEYAXJZQSs3npgN5GFaH9DDYDno8CptvBwQ5ls5y7kxuNNTbVf
 slCPiwc/Fj3Txs2KaAX6TH7PpRfVv4TC8o1i5ABuiVbEMJRi4SqYLVXMvC+x7rth1V
 p/+/aCrDV1cVAYFoq7uwgxjiEu92IiSoRDadlCAtH7iHLhwfhSmjvZg1oSvR/EC9wc
 xELPSzYhNCm7Q==
Date: Thu, 17 Aug 2023 10:06:58 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Message-ID: <20230817170658.GD1483@sol.localdomain>
References: <20230816050803.15660-1-krisman@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230816050803.15660-1-krisman@suse.de>
X-Headers-End: 1qWgSh-0085MU-C1
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
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
Cc: brauner@kernel.org, tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Aug 16, 2023 at 01:07:54AM -0400, Gabriel Krisman Bertazi wrote:
> Hi,
> 
> This is v6 of the negative dentry on case-insensitive directories.
> Thanks Eric for the review of the last iteration.  This version
> drops the patch to expose the helper to check casefolding directories,
> since it is not necessary in ecryptfs and it might be going away.  It
> also addresses some documentation details, fix a build bot error and
> simplifies the commit messages.  See the changelog in each patch for
> more details.
> 
> Thanks,
> 
> ---
> 
> Gabriel Krisman Bertazi (9):
>   ecryptfs: Reject casefold directory inodes
>   9p: Split ->weak_revalidate from ->revalidate
>   fs: Expose name under lookup to d_revalidate hooks
>   fs: Add DCACHE_CASEFOLDED_NAME flag
>   libfs: Validate negative dentries in case-insensitive directories
>   libfs: Chain encryption checks after case-insensitive revalidation
>   libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
>   ext4: Enable negative dentries on case-insensitive lookup
>   f2fs: Enable negative dentries on case-insensitive lookup
> 

Looks good,

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
