Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CD1606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 Nov 2026 05:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aBvCLS/T;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Zy0o77KM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IzsCfsoc;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FfwTOhXU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/g7RXLe0hg6oeNAn3x1CWcArMOOKQYTL7fOncoXxKOc=; b=aBvCLS/TyIN/g0m3nlG+d2cE0J
	LGut1BcTPPbBnn+H8y7Hn8QyBRfrukMShUtNbKcP+i2yn3ZSnfsbVF9lRYrLSY2ed32Et7v/KA6uc
	RJyMrbloGVU+/AIqBDMO7I9xKJfOB68dKVV7HpmX2CEd8DbxIM4nt29IRNKLid7wb4xk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTXo7-000000001Qo-2xGm;
	Wed, 18 Nov 2026 05:02:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ebiggers@kernel.org>) id 1xTXo6-000000001Qd-3HnH
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 05:02:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=buJAxVxDBcGm0+gFbF5F6hAK1IYNZp2MClhpS9+UJjA=; b=Zy0o77KMpZYjkOqtEVCHpQwe3V
 D5v2YmUmTO/2qNLs45oHvUnyxZ/VMNdvVK+s8ZxfWNJT6ahnba7+i/7WLvDzbm/it1No6LxiFp0bt
 FwGJLWZG3kCIBMo62zp4HJD/t6AB63M8LWjt02muS/Obp5BhjXqoNhZnXJMcuKTvqBVw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=buJAxVxDBcGm0+gFbF5F6hAK1IYNZp2MClhpS9+UJjA=; b=IzsCfsoc/+qxlaaYCpKgZv55jq
 7jHJ+BGbLuYZujjyD8YMl76olR8FUWPr5l2EZ4jcePFKURdoqhATMXXHAeLULAehIPnc3Zq3uZ89p
 dFFZKEqKZhJ1S2gSjmPhhNwueuDkmB8u5lRcy/AdFkX38qTAiqEknHMLJItRUC/uRvds=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTXo5-000000005LI-1jBx
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 05:02:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 08B9945852;
 Wed, 18 Nov 2026 05:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2DA1F000C4;
 Wed, 18 Nov 2026 05:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794978119;
 bh=buJAxVxDBcGm0+gFbF5F6hAK1IYNZp2MClhpS9+UJjA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FfwTOhXUXPUk+CcNccykVkrwW0f62fCOj8ajYxrUk8D3gwNNG+f0orXOYe7MAP6Ze
 kGqxVltBqpd1DH89gmYIJRQdkwTRdgv+x1IaHQx05OnBeLDC13/CE/m6d56egTdOhe
 MvxdTCzQCk1HX7V4XjpEO/fGBS+XbXedJVssoX23MdbTqGwSKvDIHVWj9jYBd13NX7
 3F6hRp/2gQq3e+Gtf8QXIk2nMYsFwVOVQMeWE03BzAl+P1CvIwyKp9p7mYD4H8y3ti
 PIYiXHtwECD1jHhA2UZK5V8gyHBn9SCHHgUujAFow9r9rAOwcSXjeyelZGYhONYPmp
 0zgXOC8W4UxXw==
Date: Tue, 17 Nov 2026 21:01:58 -0800
To: Thorsten Blum <blum@kernel.org>
Message-ID: <20261118050158.GC3400@sol>
References: <20261118002845.574426-6-blum@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261118002845.574426-6-blum@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTXo5-000000005LI-1jBx
Subject: Re: [f2fs-dev] [PATCH 0/4] fscrypt: Add FSTR() helper macro and
 convert initializers
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
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Richard Weinberger <richard@nod.at>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, linux-mtd@lists.infradead.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, David Sterba <dsterba@suse.com>,
 Chris Mason <mason@kernel.org>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 01:28:46AM +0100, Thorsten Blum wrote:
> Similar to QSTR(), add FSTR() to initialize struct fscrypt_str from a
> NUL-terminated string without specifying its length.
> 
> Use the helper for 8 initializers in btrfs, F2FS, and UBIFS, replacing
> hard-coded lengths and explicit strlen() calls.

It would be worth stating explicitly that the new strlen() calls are
constant-folded in most configurations (if they indeed are).

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
