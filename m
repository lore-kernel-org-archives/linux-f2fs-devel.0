Return-Path: <SRS0=aRy8=E6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3D9C56201
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Nov 2020 23:42:53 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8989D2137B;
	Tue, 24 Nov 2020 23:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="I0uin+5u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Eb48fbAM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0O9/cSvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8989D2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1khhxS-00036W-4P; Tue, 24 Nov 2020 23:42:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1khhxQ-00036N-0K
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Nov 2020 23:42:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GkTWrjY7E0DHligEXEmKvw+wCOBlKFhxJkBto8jy3oU=; b=I0uin+5uvnTIMex7Bynb3aHbtk
 pJ2Es2QIZq8SLioY89tuji1vaIa+w8rMjTKLTY51p5YmNG37W6Wz5obT4m1uxynyaFILx2oVYZ9wv
 nKjAIsKSH9WA5B/D/4ynC/2dnnZJIOOioG/F5HrgSppBzOHZb5XaQ6/gWTvd7ABgUHvE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GkTWrjY7E0DHligEXEmKvw+wCOBlKFhxJkBto8jy3oU=; b=Eb48fbAMnzXtDLleCpKwoKFO2l
 gh6K6ucBVG4dXFJcLo17SdSD6R4JLe5ppJ+pgZfz7JOCHi4yBQoYHDdHEZFuANQ2m0pd1b/MrZus0
 RHupUE508Q/35jenlqSeKyH1bz0sjeAzSMAQhWbuikHJPD2Mla1l4XvTGGwj7KBGWna8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1khhxA-00Dz4q-Lu
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Nov 2020 23:42:47 +0000
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net
 [172.10.235.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 608562100A;
 Tue, 24 Nov 2020 23:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606261345;
 bh=KAJWl0OBsGQqeiLErWrRxDNjM1Wbv9mxXjghZ+pYMxc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0O9/cSvw5+fLkdPBEZCzDs8Laf2SY6KdYW3Z/6HYrcr0IJ6EeqKAisLs5uEM4ePpC
 crUJACZMk75/hZFUxitjd2eP47PoB0h7bABvIHcn2y18fIf8Eptke/KsuCFhDtWdoQ
 bTUOA7zCF+KCeWdQdkrLvT0i9pe/CQyz18SUBjUw=
Date: Tue, 24 Nov 2020 15:42:22 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Message-ID: <X72aXth+cz3k7uvD@sol.localdomain>
References: <20201117032626.320275-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201117032626.320275-1-ebiggers@kernel.org>
X-Headers-End: 1khhxA-00Dz4q-Lu
Subject: Re: [f2fs-dev] [PATCH] fscrypt: simplify master key locking
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
Cc: linux-ext4@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Nov 16, 2020 at 07:26:26PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The stated reasons for separating fscrypt_master_key::mk_secret_sem from
> the standard semaphore contained in every 'struct key' no longer apply.
> 
> First, due to commit a992b20cd4ee ("fscrypt: add
> fscrypt_prepare_new_inode() and fscrypt_set_context()"),
> fscrypt_get_encryption_info() is no longer called from within a
> filesystem transaction.
> 
> Second, due to commit d3ec10aa9581 ("KEYS: Don't write out to userspace
> while holding key semaphore"), the semaphore for the "keyring" key type
> no longer ranks above page faults.
> 
> That leaves performance as the only possible reason to keep the separate
> mk_secret_sem.  Specifically, having mk_secret_sem reduces the
> contention between setup_file_encryption_key() and
> FS_IOC_{ADD,REMOVE}_ENCRYPTION_KEY.  However, these ioctls aren't
> executed often, so this doesn't seem to be worth the extra complexity.
> 
> Therefore, simplify the locking design by just using key->sem instead of
> mk_secret_sem.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/crypto/fscrypt_private.h | 19 ++++++-------------
>  fs/crypto/hooks.c           |  8 +++++---
>  fs/crypto/keyring.c         |  8 +-------
>  fs/crypto/keysetup.c        | 20 +++++++++-----------
>  4 files changed, 21 insertions(+), 34 deletions(-)

Applied to fscrypt.git#master for 5.11.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
