Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2C3C531C9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 23:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xo60wUN4oc2fBw1hkTfVhxjmbNAWdqWSOPuXIa8ELKc=; b=R0Ln7bRecexp8zCJmrzMKzPgsK
	TS+COsDwb/COHSbix13M4LKXxHNLZIM+LKRQMtOHuE6IPMowQXhAm6kANqp6MMDvrSEjBX58Gvaw6
	0wgT474TVrb8sEmvMbygM5fJrWefV28UchiQ9Vjj59KD4bzKnysDPnX8OxbaDmmvj+jk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnPUU-0007hl-F7;
	Fri, 24 Jul 2026 23:39:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wnPUU-0007hc-0k
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 23:39:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=goIlfZdhjdT3tIGjuN909d/KJf7uRaDedvTvGTi3EZE=; b=iglAPOZrPPFVyvZS/gGSTiDULx
 R6L+6NfBL91f141Jgga6YA0z4IpfMGuNeQpcGcavSLG9rGC4sJGih8fSpIWOmSPJ8WyDxZyKbDQlQ
 sYZQcyPxR/+PkZjoCN0Ov8Zl1OzxsBtBXouzqd8AU6enpefx/3+n+okSscRMUEqZqnFc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=goIlfZdhjdT3tIGjuN909d/KJf7uRaDedvTvGTi3EZE=; b=AIjMZPF1ewlkzC/geEEABNTuWb
 knM1xHLsT2FKqRcqKtjaCFmaPoTkSPzkyKsOOqOVyRXJE1zjDjp5vVXadp+9mtzzJtL+N2tODWVQX
 2JVuUWSTn8vDw/SXJhc+4/tUK1wuLf4jH0Loo0gJoE7kgzQ8hRilRFKXUF+OqBMjntLM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnPUX-0001SF-Uo for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 23:39:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A9D943C9D;
 Fri, 24 Jul 2026 23:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817A71F000E9;
 Fri, 24 Jul 2026 23:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784936376;
 bh=goIlfZdhjdT3tIGjuN909d/KJf7uRaDedvTvGTi3EZE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=oEQfFFdfTLpZP2umUFeVIz3GgOK5wrRf5ZBgxwL/tDWEEtvr3MjoC9lH4rUgIyJFn
 A9kER4SRt3W05s7bS2SstzlNEWtWwidZn09PLOc2ziyP5SUqJXGvawqxkjSeKYEUUb
 c7NAX19yVkOoOA5aOfwLb/ilQ5Yb8MsKIF9E/mAJSCpsBQv3X09cvlJoAx8pVypEa7
 iSPOWKf2Ww+tC+RZzKw9wwDjiZXDAwysoha4m9Txcs+nz0eqYAYdgH+D6c4Qf5VATB
 NEz79vcH5IUy2/EHPsrBNjnPNF69cxHT/zy9s4x0G7OlahobnvoEG/Es68ToZI4I9/
 nBGO03ubfBTXQ==
Date: Fri, 24 Jul 2026 16:37:44 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260724233744.GB1901@sol>
References: <20260721184346.416657-1-aalbersh@kernel.org>
 <20260721184346.416657-3-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260721184346.416657-3-aalbersh@kernel.org>
X-Headers-End: 1wnPUX-0001SF-Uo
Subject: Re: [f2fs-dev] [PATCH v13 02/23] fsverity: expose
 ensure_fsverity_info()
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jul 21, 2026 at 08:40:39PM +0200, Andrey Albershteyn wrote:
> +/**
> + * fsverity_ensure_verity_info() - cache verity info if it's not already cached
> + * @inode: the inode for which verity info should be cached
> + *
> + * Ensure this inode has verity info attached to it, it's assumed the inode
> + * already has fsverity enabled. Read fsverity descriptor and creates verity
> + * based on that.
> + *
> + * This needs to be called at least once before any of the inode's data
> + * can be verified (and thus read at all) or the inode's fsverity digest
> + * retrieved.  fsverity_file_open() calls this already, which handles
> + * normal file accesses.  If a filesystem does any internal (i.e. not
> + * associated with a file descriptor) reads of the file's data or
> + * fsverity digest, it must call this explicitly before doing so.
> + *
> + * Return: 0 on success, -errno on failure
> + */
> +int fsverity_ensure_verity_info(struct inode *inode)

There really should be a note here that if the file is also encrypted,
then the encryption key has to have been set up first.  This was already
gotten wrong when it was proposed for overlayfs to call this.

Do we also need a more specific contract than "-errno on failure"?  The
caller in xchk_inode_setup_verity() tries to distinguish between
"metadata validation errors" and "runtime errors" by checking for a
bunch of different error codes, and I'm not sure what that means
exactly.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
