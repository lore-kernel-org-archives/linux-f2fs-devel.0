Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6CF606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EKHFiCmo;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Y1pFkNSF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QjfGTM74;
	dkim=neutral header.d=krisman.be header.i=@krisman.be header.a=rsa-sha256 header.s=MBO0001 header.b=h/B9EEoZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:References:In-Reply-To:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=upUR5s7EZUYX+rAbYdpUMD+mVa9kbQxFFJHKpYyNPEE=; b=EKHFiCmoW7jH826JRv2cXxTsWY
	tahb9c+9pGeQBq2dpvK8p1HEJ1LKBIt7wp+Lw3vnHnSyStJQABeG4xBq/vjYzDD1kFhBXC+xHaYxv
	FNnFYkLLC4539Ah4SZTCwPoeZqC6AVn3PPifNIRQojLUQL24ZrX84cxDD29l2oMFkWkc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xT3Qa-000000008BN-081d;
	Mon, 16 Nov 2026 20:35:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gabriel@krisman.be>) id 1xT3QW-000000008B4-1VM1
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 20:35:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KA1DiuFm9cFLOOwb5cT6/nPwPW+KUR82vQTkyGv9uNg=; b=Y
 1pFkNSFp3fHAn9aZr80oA39EfxbKBsGXLU0b/vV++FlsUefJzyCdwKr16Ui8pN+hDRcpWNglNf+sZ
 v7H3eP5vMQ3aFbiSsPLeBssnzTXvvAm5g8GgZwOQdbU/+JPwpM9H0Bzobq4WOJQKmu7x8JnAAeVui
 9QkeRVBVV0mnSafA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KA1DiuFm9cFLOOwb5cT6/nPwPW+KUR82vQTkyGv9uNg=; b=QjfGTM74OmUNsUaFmtmD4Hi3R6
 Xgh9YmnSJQfEepFVBzw+I9a8QDSM9fhpo3si1MPzbVQ65KZjkDqKD+8igBGqHkHr4wmmancjNmFNt
 7gl7NIlD2qfbjvQ8rFrmBKzX6gf3Y6YXO4dKduxWv7P9P6bCmvf46orCF/40K7hgrUAs=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xT3QU-000000005uD-25V8
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 20:35:44 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jSzgV1bNczMlgs;
 Mon, 16 Nov 2026 21:17:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=MBO0001; 
 t=1794860262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KA1DiuFm9cFLOOwb5cT6/nPwPW+KUR82vQTkyGv9uNg=;
 b=h/B9EEoZDO62fbuuaIdNx+TktwDc2CTr0cHXesXGMM1BCbPdUFIhsDg1z3G60HsU5bknwL
 LoyyVqOQZ8xVlww1e2QKpZBhr8dlz8NbL05sgwZjcxLiDkBtcYd+ZodPkRDEB4gJ/WCK+v
 RR0hviDWV34L9kpo3A3Bz9vON13jAuq2r2Is0CiU6VaxK/eSmW1kAb7KrudNBHeaD48Qoi
 tPCune9l23JkLJOycIXRxJBVQD1k79K1eH/XTqCX5e0J50TR9MWsGUfuJJn2NhntlSCX1m
 gP6HBFKxIZZ0Hv/IRmEy802TK4Ke/VIffo8jrqdx+B+cvNQ2E2f3QSsF59Ib9g==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of gabriel@krisman.be designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=gabriel@krisman.be
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Eric Biggers <ebiggers@kernel.org>, Zhan Xusheng
 <zhanxusheng1024@gmail.com>
In-Reply-To: <20261116194845.GC229817@google.com>
References: <20261103030712.1514800-1-zhanxusheng1024@gmail.com>
 <20261116194845.GC229817@google.com>
Date: Mon, 16 Nov 2026 15:17:37 -0500
Message-ID: <874idgwmxq.fsf@cartola>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jSzgV1bNczMlgs
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xT3QU-000000005uD-25V8
Subject: Re: [f2fs-dev] [RFC PATCH] f2fs: fold casefolded names of
 F2FS_NAME_LEN bytes
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: zhanxusheng@xiaomi.com, andrealmeid@igalia.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Eric Biggers <ebiggers@kernel.org> writes:

> [ +Cc Gabriel, who maintains fs/unicode/ ]
>
> On Tue, Nov 03, 2026 at 11:07:12AM +0800, Zhan Xusheng wrote:
>> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
>> 
>> utf8_casefold() needs room for the terminating NUL, but
>> f2fs_init_casefolded_name() gives it only F2FS_NAME_LEN bytes, so a
>> name that folds to exactly 255 bytes is not folded. In a casefolded
>> directory, creating 'A' x 255 fails with EINVAL under utf8:strict.
>> Without strict, after creating 'A' x 255, stat of 'a' x 255 returns
>> ENOENT and creating it adds a second entry.
>> 
>> Fold into F2FS_NAME_LEN + 1 bytes. Existing entries for these names
>> are hashed by the name as given, so on a miss also try that hash.
>> 
>> Fixes: 43c780ba2624 ("f2fs: rework filename handling")
>> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
>> ---
>> RFC because new entries for these names get a different hash on disk.
>> Results in a VM, with dentries dropped before each stat:
>> 
>>                                  'A'x255  'a'x255  'C'x255  'c'x255
>>   current kernel creates 'A'        ok    ENOENT
>>   this patch creates 'C', 'c'       ok    ENOENT     ok       ok
>>                                     (one 'c' entry)
>>   back on the current kernel        ok    ENOENT   ENOENT   ENOENT
>>   strict, current kernel        create 'S' x 255: EINVAL
>>   strict, this patch            create ok, found in both cases
>> 
>> Each fsck.f2fs version matches only one side. 1.16 folds into PATH_MAX
>> and rewrote 'A' to the folded hash, after which the current kernel
>> cannot find it. The dev branch rewrote 'C' to the raw hash, after
>> which this patch finds it only as 'C'. fsck would need to accept both
>> hashes for these names. Encrypted directories are not tested.
>> 
>> Is the second lookup acceptable? The alternative is to keep hashing
>> these names as given, which fixes the EINVAL but leaves them
>> case-sensitive.
>
> Sorry about this bug!
>
> I think it's actually worse than you say, and this commit doesn't fix it
> entirely.  A filename can "casefold" (really NFD canonical decomposition
> + Default_Ignorable_Code_Point stripping + full casefolding) to much
> more than F2FS_NAME_LEN bytes.  The decomposition stage in particular
> can result in significant expansion, up to 3 * F2FS_NAME_LEN.

This was a known limitation, the actual limit for casefolded names is
much less than 255, it is actually the size of the folded version of the
string.  I still suspect this limit is hardly a real problem in
practice.  The bug is the inconsistency in creating a casefolded dentry
and then failing to hash the same dentry. That's a bug in the
implementation.

> For ASCII though it is indeed as you say: they cannot expand, and only
> max-length filenames are affected due to the off-by-one caused by
> utf8_casefold() unexpectedly including a NUL terminator.
>
> I think this shows that the 'casefold' feature` isn't really used for
> anything other than ASCII in practice, and all the complexity of Unicode
> normalization wasn't needed in the first place...

I wish. We can debate whether it is a "good" usecase or not all day, but
from prior bug reports it is clear people are using casefolding way
beyond ASCII or even accented characters.  For an extreme example, see
the variant selectors mess from when we tried to change the casefolding
of ignorable code-points a couple years ago.  Clearly there were
mistakes in supporting the entire unicode map, but ASCII if far from
enough for anyone who speaks !english.

> But I suppose this should be fixed anyway.  The approach of this patch
> should generally be okay if you increase the buffer to the required
> '3 * F2FS_NAME_LEN + 1'.
>
> However, please check the Sashiko comments
> https://sashiko.dev/#/patchset/20261103030712.1514800-1-zhanxusheng1024%40gmail.com
> as some issues were found with the implementation.
>
> - Eric

-- 
Gabriel Krisman Bertazi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
