Return-Path: <SRS0=vASv=AF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB9DC433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jun 2020 05:35:24 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2228206EB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jun 2020 05:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="LlkjQXDF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Zj1ZzHMU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aH7ky+hF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2228206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jny4B-000112-DX; Wed, 24 Jun 2020 05:35:23 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jny49-00010v-LS
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Jun 2020 05:35:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sVgFRK5hCS9yNjKXnpj9BuJQUmjo9a5e5wL3kV0WUBk=; b=LlkjQXDF6mVi0PqmTZOUivlZlr
 lC//oWc/ruYDE7oWko1hJETg/ot2RWYma1xZ5ORf2lgfsibjDo1Qyj4zQV71y4KDa/LBfdFCVTxa7
 r/qKPklSCqILDSuw2ZfCyQQYuHg9AfmMRiA+hGezpk7IIEp4b9/0qtrXARKkEDwCa/mI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sVgFRK5hCS9yNjKXnpj9BuJQUmjo9a5e5wL3kV0WUBk=; b=Zj1ZzHMU0tyhQEbFlGVOYVYMr2
 mH+aNTy0GpDKgh0zDAFOlnM0mI+pZnpUKU7ESaIcxRWKhJPRnxw4mG0fhgextApxFzoablrv1GnCU
 Ifyrqt9VE/uMN9mAKroRTRwtOL3dzl19xDKNLQZi4ds4hcLFdmm/gHZq1pgsjnZ/BSvg=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jny48-00Gi62-H8
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Jun 2020 05:35:21 +0000
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1E7FA2072E;
 Wed, 24 Jun 2020 05:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592976900;
 bh=Uvdb15+FwGUGLj2jhaGU6/DgaIrNmpWsV+ez1RtkBmM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aH7ky+hF/Jg1QGfBvwiqKCHIP0MpTE4LW78vI6dhtosOeYKEh+oTVtkYpAvkWt0iL
 ShgtMzLXPriGly+wa1+m9TELZOjEkpmRhniqkY7PbvwGbJ75CBOxbWj/lDddErBOg3
 6QVCfLlt6ajSXNSYRvGVdcGxxdHPpG/B6o059JkA=
Date: Tue, 23 Jun 2020 22:34:58 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Daniel Rosenberg <drosen@google.com>
Message-ID: <20200624053458.GD844@sol.localdomain>
References: <20200624043341.33364-1-drosen@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200624043341.33364-1-drosen@google.com>
X-Headers-End: 1jny48-00Gi62-H8
Subject: Re: [f2fs-dev] [PATCH v9 0/4] Prepare for upcoming
 Casefolding/Encryption patches
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
Cc: kernel-team@android.com, Theodore Ts'o <tytso@mit.edu>,
 Jonathan Corbet <corbet@lwn.net>, Richard Weinberger <richard@nod.at>,
 Andreas Dilger <adilger.kernel@dilger.ca>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, linux-mtd@lists.infradead.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jun 23, 2020 at 09:33:37PM -0700, Daniel Rosenberg wrote:
> This lays the ground work for enabling casefolding and encryption at the
> same time for ext4 and f2fs. A future set of patches will enable that
> functionality. These unify the highly similar dentry_operations that ext4
> and f2fs both use for casefolding.

I think this undersells this patchset a bit.  This patchset makes ext4 and f2fs
share the casefolded ->d_compare() and ->d_hash() implementations, which
eliminates duplicated code.  That's a good thing regardless of whether we're
going to add encrypt+casefold support or not.

It also changes the casefolded ->d_hash() implementation to not have to allocate
memory (with GFP_ATOMIC, no less), which was a big problem with the old
implementation as it's unreliable and inefficient.

So yes, this prepares for supporting encrypt+casefold.  But these changes make
sense on their own too as an improvement of the casefold feature.  Except for
the one line of code in needs_casefold() that is specific to encrypt+casefold;
maybe that should be left out for now.

(Side note: I think you could drop linux-doc and linux-mtd from Cc, as this
patchset isn't really relevant to those mailing lists.)

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
