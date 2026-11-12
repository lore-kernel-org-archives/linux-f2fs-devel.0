Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23A7606A33E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NZckoPxa;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FOHvb+5i;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZK71szih;
	dkim=neutral header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=ofZudNUj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:References:In-Reply-To:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=Cz8SW0w0Cgnc9PCQ4Q4DUHgEgdGvUyT1/K0z0Kp1d5U=; b=NZckoPxaFyU2mYK1OiPfzVH/th
	9qVKTMzgIrd4s2WJX/lRsvIM2ypYgOEGHYvGgFVWdTC/mj3ee8W53+MuGIHLb9dUkIIblm1g0M5bX
	9tg8TbcXUsMksf6/61iycboQ/d21ntZ3NePtPWCrjPQgH0Of03T143KBJ7273BfM6TDI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRWX4-000000000u3-3thZ;
	Thu, 12 Nov 2026 15:16:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <corbet@lwn.net>) id 1xRWWn-000000000tc-21pK
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 15:15:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mJiAcVKGt20rwDbtZ267Ib5ukUoWE5uGUXiOfLnifSI=; b=F
 OHvb+5iinN1MnTFNMbQmE4QDSytezkuXmtB3O3005OcJPoxp38ouE5bjknIKmwmhlCqDRFQ5zQF/e
 U38ynGkeyAHaOr/CuvKY3TIX4O7l07c1IWQEdFrGkvOYtVaKJel354SbmseOhZscLX0erlytV2iUa
 1nJe/AhouhHEW+hw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mJiAcVKGt20rwDbtZ267Ib5ukUoWE5uGUXiOfLnifSI=; b=ZK71szihjKrRoQm6NxfJrdtSXL
 mglaksOvUOkdDoXtqwVM5ZJfedfuRdkd0tHst/O40gw+soxoO3ucPqwcRYfJz2FWmKLziGrzi3jjU
 gw/IPJNfIUmLrLDr7Tz1NVWFjB7M+Rw2ADk1xniOpdLCu47tN44Zh0iTMkij4qTsLbZk=;
Received: from ms.lwn.net ([45.79.88.28])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRWWj-000000004Sb-0vQq
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 15:15:53 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7A40140E3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
 t=1794495488; bh=mJiAcVKGt20rwDbtZ267Ib5ukUoWE5uGUXiOfLnifSI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ofZudNUjfxzIuc9YnHvCSMNP3UdhwIEUjeA4Qksu4oSV+kcM2Zkdw0VZqr+bnMNoQ
 8sGZX0i2YEdZVE4tgmRCyk8os5+9sSkmT2qP01AXr9+rDeoaLCypLarG9JLbctGmR4
 oSlhUO3rwjREHzNMlo7L/D3l6TTO8Lk0UJqMkYkir5EDJuTvdXUDelPVFZ36TS+piu
 to2OPMtqoH34RZiQt531jjc2Glmh2phGWbqzitA55enpGpOmmtGkDdNChOeBpQh+oP
 EGLEAolGcdJirv0Onhhoi0aajMz114GBmM1JQQbtGbNOsambcbftbkfVDP9lu6j0xd
 yWJ5CH3/s8y7w==
Received: from localhost (unknown [151.38.237.230])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256) (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id 7A40140E3D;
 Thu, 12 Nov 2026 14:58:07 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
In-Reply-To: <20261103033713.2709978-1-rdunlap@infradead.org>
References: <20261103033713.2709978-1-rdunlap@infradead.org>
Date: Thu, 12 Nov 2026 07:58:04 -0700
Message-ID: <874idm6qrn.fsf@trenco.lwn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xRWWj-000000004Sb-0vQq
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix various ABI documentation issues
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Randy Dunlap <rdunlap@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, Shuah Khan <skhan@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Randy Dunlap <rdunlap@infradead.org> writes:

> Clean up the f2fs sysfs ABI documentation:
> - use "number" instead of "#"
> - use "seconds" instead of "secs"
> - remove an extraneous period ('.')
> - add a space for better readability
> - fix grammar, spelling, & punctuation
> - break up comma splices
> - use a list for "gc_urgent"
> - add a blank line for the list in "extension_list" &
>   "effective_lookup_mode"
>
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Chao Yu <chao@kernel.org>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
>
>  Documentation/ABI/testing/sysfs-fs-f2fs |  114 +++++++++++-----------
>  1 file changed, 61 insertions(+), 53 deletions(-)

Applied, thanks.

jon


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
