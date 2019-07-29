Return-Path: <SRS0=MGGM=V2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82CAC433FF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jul 2019 19:37:55 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9336920C01;
	Mon, 29 Jul 2019 19:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="EkkmxtlV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="bMKSnEjO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgTCz2CW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9336920C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hsBT0-0001Vr-U7; Mon, 29 Jul 2019 19:37:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hsBSy-0001VX-Vh
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jul 2019 19:37:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vOUpWH75c/PvyEuwx65rdlI2u9m54sjzRCuUcU7Dd1s=; b=EkkmxtlV0tFBabvIGj7XtUVZ3L
 BzS8FifBemR2qPYB+Fj5sm+kXiZpHLtI+zCWOMUqBJh5kVmESy5fR7osn7/7SxlHy+78ZQYhH8gnU
 hvwA+Uh4GasygQQJx+PuR6pdhUKBdiIs5UKELmp4naiP11iR3MrXyY9Qjf0pyF0wxVEA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vOUpWH75c/PvyEuwx65rdlI2u9m54sjzRCuUcU7Dd1s=; b=bMKSnEjO8ccwSPaDwVNN+UArk7
 R2UOoTLHF9VfftS89u54uUtZA6nxOxPIh0OSwE0qfgaoloFU8//LsDGYqbsjlegvx2PT2n6aXkRas
 34usCj3YHirEa1IlZib54xE5cwm9D/Xs5yZEiltQlGWOnOfBOtk3ALSlepMONuJX7goM=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hsBSv-00FkOg-DJ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jul 2019 19:37:52 +0000
Received: from gmail.com (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6E126206DD;
 Mon, 29 Jul 2019 19:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1564429063;
 bh=35ZwmfXjVkjcTD49ueQekrtcYmxgdRwDGATcxQouXLg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QgTCz2CWqZ9GLFMzgaQtbnyPki0Oxg8qrvTR97l00Gc8CQzx+zc2oXmp7EWb24DL7
 lqI1c/qw8hCySTW9XZjhkJGofi5da7NFa4tbNNzKq3SlAVuvZteu0lZkG1ZnucaL4j
 QUyqoTdTCGY36VS+Fv9/JDNLvuGsN+DnFosM0q6c=
Date: Mon, 29 Jul 2019 12:37:42 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Message-ID: <20190729193740.GD169027@gmail.com>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
 linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
 Paul Crowley <paulcrowley@google.com>,
 Satya Tangirala <satyat@google.com>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-6-ebiggers@kernel.org>
 <20190728154032.GE6088@mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190728154032.GE6088@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1hsBSv-00FkOg-DJ
Subject: Re: [f2fs-dev] [PATCH v7 05/16] fscrypt: refactor v1 policy key
 setup into keysetup_legacy.c
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
Cc: Satya Tangirala <satyat@google.com>, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org,
 keyrings@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, Paul Crowley <paulcrowley@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Ted, thanks for the review!

On Sun, Jul 28, 2019 at 11:40:32AM -0400, Theodore Y. Ts'o wrote:
> On Fri, Jul 26, 2019 at 03:41:30PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > In preparation for introducing v2 encryption policies which will find
> > and derive encryption keys differently from the current v1 encryption
> > policies, refactor the v1 policy-specific key setup code from keyinfo.c
> > into keysetup_legacy.c.  Then rename keyinfo.c to keysetup.c.
> 
> I'd use keysetup_v1.c, myself.  We can hope that we've gotten it right
> with v2 and we'll never need to do another version, but *something* is
> going to come up eventually which will require a v3 keysetup , whether
> it's post-quantuum cryptography or something else we can't anticipate
> right now.
> 
> For an example of the confusion that can result, one good example is
> in the fs/quota subsystem, where QFMT_VFS_OLD, QFMT_VFS_V0, and
> QFMT_VFS_V1 maps to quota_v1 and quota_v2 in an amusing and
> non-obvious way.  (Go ahead, try to guess before you go look at the
> code.  :-)
> 
> Other than that, looks good.  We can always move code around or rename
> files in the future, so I'm not going to insist on doing it now (but
> it would be my preference).
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> 

Agreed, I'll call it keysetup_v1.c instead.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
